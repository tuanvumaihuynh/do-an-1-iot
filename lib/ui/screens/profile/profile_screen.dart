import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/ui/screens/profile/sections/body_profile.dart';
import 'package:do_an_1_iot/ui/screens/profile/sections/header_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderProfile(),
              SizedBox(height: AppSizes.defaultPadding * 2),
              BodyProfile(),

              ///
              ///
              ///
              /// Just for testing
              ///
              ///
              ///
            ],
          ),
        ),
      ),
    );
  }
}
