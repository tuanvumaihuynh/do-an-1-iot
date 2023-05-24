import 'dart:io';

import 'package:do_an_1_iot/constants/colors.dart';

import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:do_an_1_iot/services/realtime_database_service.dart';
import 'package:do_an_1_iot/ui/screens/profile_setting/widgets/list_tile_widget.dart';
import 'package:do_an_1_iot/ui/screens/profile_setting/widgets/photo_select_widget.dart';
import 'package:do_an_1_iot/ui/screens/profile_setting/widgets/title_widget.dart';
import 'package:do_an_1_iot/ui/widgets/avatar_image.dart';
import 'package:do_an_1_iot/ui/widgets/custom_app_bar.dart';
import 'package:do_an_1_iot/ui/widgets/custom_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/data_provider.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final userModel = dataProvider.userModel;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'Personal Info'),
              const SizedBox(height: AppSizes.defaultPadding),
              const TitleWidget(title: 'Personal info'),
              const SizedBox(height: AppSizes.defaultPadding),
              _buildProfilePhoto(context, userModel!.photoUrl!),
              ListTileWidget(
                title: 'Account ID',
                data: userModel.id,
              ),
              ListTileWidget(
                title: 'Name',
                data: userModel.name,
                canEdited: true,
              ),
              const Divider(),
              const SizedBox(height: AppSizes.defaultPadding),
              const TitleWidget(title: 'Add account'),
              const SizedBox(height: AppSizes.defaultPadding / 2),
              const ListTileWidget(
                title: 'Google account',
                data: 'Not pair',
              ),
              const Divider(),
              const SizedBox(height: AppSizes.defaultPadding),
              const TitleWidget(title: 'Email and phone number'),
              const SizedBox(height: AppSizes.defaultPadding / 2),
              ListTileWidget(
                title: 'Email',
                data: userModel.email,
              ),
              ListTileWidget(
                  title: 'Phone number',
                  data: userModel.phoneNumber!,
                  canEdited: true),
              const Divider(),
              const SizedBox(height: AppSizes.defaultPadding),
              _buildSignOutButton(context, dataProvider),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoOptions(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (context) => PhotoSelectWidget(onTap: _handleUploadImage));
  }

  Future _handleUploadImage(
      BuildContext context, ImageSource imageSource) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;

      // Show loading dialog
      // ignore: use_build_context_synchronously
      CustomDialog.showLoadingDialog(context);
      // Handle upload
      final date = _formatDate();
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef =
          storageRef.child('users/${AuthService.currentUser!.uid}/$date.png');

      File file = File(image.path);

      await imageRef.putFile(file);
      final imageUrl = await imageRef.getDownloadURL();
      await RealtimeDatabaseService.updateData(
          'users/${AuthService.currentUser!.uid}', {'photo_url': imageUrl});

      // Pop loading dialog
      AppNavigator.pop();

      // Pop modal bottom
      AppNavigator.pop();
    } catch (e) {
      //
    }
  }

  String _formatDate() {
    final now = DateTime.now();
    final String formattedDate = DateFormat('dd-mm-yyyy-kk-mm-ss').format(now);
    return formattedDate;
  }

  Widget _buildProfilePhoto(BuildContext context, String photoUrl) => InkWell(
        onTap: () {
          CustomDialog.showImageDialog(context, photoUrl);
        },
        onLongPress: () {
          _showPhotoOptions(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Profile photo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            ClipOval(
                child: AvatarImageCustom(
              photoUrl: photoUrl,
              imageSize: 50,
            )),
          ],
        ),
      );

  Widget _buildSignOutButton(BuildContext context, DataProvider dataProvider) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            // Sign out
            await AuthService.signOut();

            dataProvider.clearUserData();
            // Navigate to Sign in screen
            await AppNavigator.replaceWithThenRemoveAllCurrentRoute(
                Routes.signIn);
          },
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Text("Sign Out"),
          ),
        ),
      );
}
