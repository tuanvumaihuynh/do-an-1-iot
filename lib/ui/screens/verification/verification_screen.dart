// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/models/user_model.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:do_an_1_iot/services/realtime_database_service.dart';
import 'package:do_an_1_iot/ui/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    isVerified = AuthService.emailVerified;

    if (!isVerified) {
      handleVerification();

      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => checkEmailVerified(),
      );
    }

    super.initState();
  }

  @override
  void dispose() async {
    if (!isVerified) {
      timer!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSizes.defaultPadding),
                const Text(
                  'Verification',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.defaultPadding * 10),
                _buildSendEmailButton(),
                const SizedBox(height: AppSizes.defaultPadding),
                _buildCancelButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendEmailButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canResendEmail ? handleVerification : null,
          style: TextButton.styleFrom(
              // backgroundColor: const Color(0xFF6CD8D1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Text("Resend email"),
          ),
        ),
      );

  Widget _buildCancelButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            await handleCancel();
          },
          style: TextButton.styleFrom(
              // backgroundColor: const Color(0xFF6CD8D1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Text("Cancel"),
          ),
        ),
      );

  Future<void> handleCancel() async {
    final AuthResult result = await AuthService.signOut();

    if (!result.success) {
      await AppNavigator.replaceWith(Routes.signIn);
    } else {
      SnackBarCustom.showSnackBar(context, result.response);
    }
  }

  Future<void> handleVerification() async {
    await AuthService.verifyEmail();

    setState(() => canResendEmail = false);

    await Future.delayed(const Duration(seconds: 5));

    setState(() => canResendEmail = true);
  }

  Future<void> checkEmailVerified() async {
    await AuthService.reloadUser();

    setState(() {
      isVerified = AuthService.emailVerified;
    });

    if (isVerified) {
      timer?.cancel();

      // Get save userModel
      UserModel? userModel =
          Provider.of<DataProvider>(context, listen: false).userModel;

      // Create user

      await RealtimeDatabaseService.updateData('users', userModel!.toJson());

      // Navigate to main screen
      await AppNavigator.replaceWith(Routes.main);
    }
  }
}
