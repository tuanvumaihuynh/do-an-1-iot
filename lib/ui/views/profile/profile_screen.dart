import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/ui/views/profile/widgets/sub_content_profile_widget.dart';
import 'package:do_an_1_iot/ui/views/profile/widgets/profile_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _borderRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.DEFAULT_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserProvider>(builder: ((context, data, child) {
              if (data.userModel != null) {
                return ProfileWidget(userModel: data.userModel!);
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.PRIMARY_COLOR,
                ));
              }
            })),
            const SizedBox(height: AppSizes.DEFAULT_PADDING * 2),
            Column(
              children: [
                SubContentProfileWidget(
                  iconData: Icons.share_outlined,
                  text: 'Share',
                  top: _borderRadius,
                ),
                const SubContentProfileWidget(
                    iconData: Icons.bluetooth, text: 'Bluetooth'),
                const SubContentProfileWidget(
                    iconData: Icons.keyboard_voice_outlined,
                    text: 'Voice service'),
                SubContentProfileWidget(
                  iconData: Icons.settings_outlined,
                  text: 'Settings',
                  bottom: _borderRadius,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.DEFAULT_PADDING / 2),
            SubContentProfileWidget(
              iconData: Icons.window_rounded,
              text: 'Third party access',
              top: _borderRadius,
              bottom: _borderRadius,
            ),
            const SizedBox(height: AppSizes.DEFAULT_PADDING / 2),
            Column(
              children: [
                SubContentProfileWidget(
                  iconData: Icons.add_link_outlined,
                  text: 'How this project work',
                  top: _borderRadius,
                ),
                SubContentProfileWidget(
                  iconData: Icons.feedback_outlined,
                  text: 'Help & Feedback',
                  bottom: _borderRadius,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
