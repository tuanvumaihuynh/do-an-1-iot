import 'package:do_an_1_iot/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/sizes.dart';
import '../widgets/custom_button.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkModeOn = Provider.of<ThemeProvider>(context).isDarkModeOn;

    double borderRadius = 15.0;

    return Column(
      children: [
        CustomButton(
          iconData: Icons.bluetooth,
          text: 'Bluetooth',
          vertical: borderRadius,
        ),
        const CustomButton(
            iconData: Icons.keyboard_voice_outlined, text: 'Voice service'),
        CustomButton(
          iconData: isDarkModeOn ? Icons.sunny : Icons.mode_night_outlined,
          text: isDarkModeOn ? 'Light mode' : 'Dark mode',
          horizontal: borderRadius,
          onTap: (() {
            _changeTheme(context);
          }),
        ),
        const SizedBox(height: AppSizes.defaultPadding),
        CustomButton(
          iconData: Icons.window_rounded,
          text: 'Third party access',
          vertical: borderRadius,
          horizontal: borderRadius,
        ),
        const SizedBox(height: AppSizes.defaultPadding),
        CustomButton(
          iconData: Icons.add_link_outlined,
          text: 'How this project work',
          vertical: borderRadius,
        ),
        CustomButton(
          iconData: Icons.feedback_outlined,
          text: 'Help & Feedback',
          horizontal: borderRadius,
        ),
      ],
    );
  }

  void _changeTheme(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }
}
