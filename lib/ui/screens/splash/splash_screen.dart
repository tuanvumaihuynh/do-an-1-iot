// ignore_for_file: always_specify_types

import 'dart:async';

import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/images.dart';
import '../../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final double _splashIconSize = 200;

  @override
  void initState() {
    scheduleMicrotask(() async {
      await AppImages.precacheAssets(context);

      ///
      /// This delay section for fetching data
      ///
      await Future.delayed(const Duration(milliseconds: 500));

      _handleRoutes();
    });

    super.initState();
  }

  Future<void> _handleRoutes() async {
    bool isLoggedIn = AuthService.currentUser != null;
    bool isEmailVerified = AuthService.emailVerified;

    if (isLoggedIn && isEmailVerified) {
      await AppNavigator.replaceWith(Routes.main);
    }

    if (isLoggedIn && !isEmailVerified) {
      await AuthService.signOut();
      await AppNavigator.replaceWith(Routes.signIn);
    }

    if (!isLoggedIn) {
      await AppNavigator.replaceWith(Routes.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AppImages.logo,
              width: _splashIconSize,
              height: _splashIconSize,
              fit: BoxFit.contain,
            ),
            const Text(
              'Smartify',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
