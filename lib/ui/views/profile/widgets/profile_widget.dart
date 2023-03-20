import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_images.dart';
import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/models/user_model.dart';
import 'package:do_an_1_iot/ui/views/profile/edit_profile_screen.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.of(context)
          .push(AppRoute.fadeInAnimation(const EditProfileScreen()))),
      child: Padding(
        padding: const EdgeInsets.only(left: AppSizes.DEFAULT_PADDING / 2),
        child: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                  imageUrl: userModel.photoUrl!,
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
            const SizedBox(width: AppSizes.DEFAULT_PADDING),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    userModel.email,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xFF7F7F7F), fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
