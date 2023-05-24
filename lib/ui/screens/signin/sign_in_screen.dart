// ignore_for_file: use_build_context_synchronously

import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:do_an_1_iot/ui/screens/signin/sections/sign_in_form.dart';
import 'package:do_an_1_iot/ui/widgets/custom_dialog.dart';
import 'package:do_an_1_iot/ui/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

import '../../../../constants/images.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

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
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.defaultPadding),
                const Text(
                  'Enter your credentials to continue.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.defaultPadding * 3),
                SignInForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                _buildForgotPasswordButon(),
                _buildSignInButton(),
                const SizedBox(height: AppSizes.defaultPadding * 2),
                _buildDivider(),
                const SizedBox(height: AppSizes.defaultPadding * 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {},
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AppImages.googleIcon,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: AppSizes.defaultPadding),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.defaultPadding * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?"),
                    TextButton(
                      onPressed: () async {
                        await AppNavigator.replaceWith(Routes.signUp);
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    // Show dialog loading
    CustomDialog.showLoadingDialog(context);

    // Call the function signInWithEmailAndPassword to perform login, pass in email and password
    final AuthResult result = await AuthService.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    // If login fails, display SnackBar error message
    if (!result.success) {
      // Hide dialog loading
      AppNavigator.pop();

      // Display SnackBar with error message
      SnackBarCustom.showSnackBar(context, result.response);
    } else {
      // Hide dialog loading
      AppNavigator.pop();

      // Login successfully, check verification
      final bool isVerified = AuthService.emailVerified;

      if (isVerified) {
        await AppNavigator.replaceWith(Routes.main);
      } else {
        await AppNavigator.replaceWith(Routes.verification);
      }
    }
  }

  Widget _buildForgotPasswordButon() => Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            "Forgot password?",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      );

  Widget _buildSignInButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus(); //to hide the keyboard

              _formKey.currentState!.save(); // It saved our inputs

              await _handleSignIn();
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Text("Sign In"),
          ),
        ),
      );

  Widget _buildDivider() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(child: Divider(thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Or continue with"),
          ),
          Expanded(child: Divider(thickness: 1)),
        ],
      );
}
