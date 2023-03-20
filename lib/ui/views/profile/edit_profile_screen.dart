import 'dart:io';
import 'package:do_an_1_iot/utils/cache_management.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:do_an_1_iot/ui/views/profile/widgets/photo_view_widget.dart';
import 'package:do_an_1_iot/ui/views/profile/widgets/select_photo_options_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_images.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/ui/views/profile/widgets/personal_info_line_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  void _showSelectPhotoOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: ((context) =>
          SelectPhotoOptionsWidget(onTap: _pickImageThenUpload)),
    );
  }

  Future<void> _uploadImageToStorage(String imagePath) async {
    final date = _formatDate();
    final userUid = UserProvider.currentUser!.uid;
    final userDatabase = FirebaseDatabase.instance.ref('users');
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('users/$userUid/$date.png');
    File file = File(imagePath);

    try {
      await imageRef.putFile(file);
      final imageUrl =
          await storageRef.child('users/$userUid/$date.png').getDownloadURL();
      await userDatabase.child(userUid).update({'photoUrl': imageUrl});
    } catch (e) {
      //
    }
  }

  Future _pickImageThenUpload(ImageSource source, BuildContext context) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      await _uploadImageToStorage(image.path);
      Navigator.of(context).pop();
    } catch (e) {
      //
      Navigator.of(context).pop();
    }
  }

  String _formatDate() {
    final now = DateTime.now();
    final String formattedDate = DateFormat('dd-mm-yyyy-kk-mm-ss').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserProvider>().userModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Personal info',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.DEFAULT_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal info',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF666666),
                    ),
              ),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING,
              ),
              InkWell(
                onTap: (() => Navigator.of(context)
                        .push(AppRoute.fadeInAnimation(PhotoViewWidget(
                      photoUrl: userModel.photoUrl!,
                    )))),
                onLongPress: () {
                  _showSelectPhotoOptions(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Profile photo',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    ClipOval(
                      child: CachedNetworkImage(
                          imageUrl: userModel!.photoUrl!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                  color: AppColors.PRIMARY_COLOR),
                          errorWidget: ((context, url, error) => Image.asset(
                                AppImages.DEFAULT_AVATAR,
                                height: 50,
                                width: 50,
                              ))),
                    ),
                  ],
                ),
              ),
              PersonalInfoLineWidget(title: 'Account ID', data: userModel.id),
              PersonalInfoLineWidget(
                  title: 'Name',
                  data: userModel.name,
                  canEdited: true,
                  uid: userModel.id),
              const Divider(),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING,
              ),
              Text(
                'Add account',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: const Color(0xFF666666)),
              ),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING / 2,
              ),
              PersonalInfoLineWidget(
                  title: 'Google account', data: 'Not paired'),
              const Divider(),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING,
              ),
              Text(
                'Email and phone number',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: const Color(0xFF666666)),
              ),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING / 2,
              ),

              PersonalInfoLineWidget(title: 'Email', data: userModel.email),
              PersonalInfoLineWidget(title: 'Phone number', data: 'null'),
              const Divider(),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING * 7,
              ),
              // Sign out button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await FirebaseAuth.instance.signOut();
                      await context.read<UserProvider>().cancelSub();
                      await CacheManagement.clearCache();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.PRIMARY_COLOR,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Sign out'),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
