// ignore_for_file: use_build_context_synchronously

import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:do_an_1_iot/ui/screens/signup/sections/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes.dart';
import '../../../constants/colors.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSizes.defaultPadding),
                const Text(
                  'Create a profile and connect to your smarthome',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.defaultPadding * 2),
                SignUpForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: AppSizes.defaultPadding * 2),
                _buildSignUpButton(),
                const SizedBox(height: AppSizes.defaultPadding * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () async {
                        await AppNavigator.replaceWith(Routes.signIn);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    // Show dialog loading
    CustomDialog.showLoadingDialog(context);

    // Call the function registerWithEmailAndPassword to perform register, pass in email and password
    final AuthResult result = await AuthService.registerWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    // If login fails, display SnackBar error message
    if (!result.success) {
      // Hide dialog loading
      AppNavigator.pop();

      // Display SnackBar with error message content
      SnackBarCustom.showSnackBar(context, result.response);
    } else {
      // Hide dialog loading
      AppNavigator.pop();

      // Save user model
      Provider.of<DataProvider>(context, listen: false)
          .saveUserModel(_nameController.text, _emailController.text);

      // Register successfully, go to Verification screen
      await AppNavigator.replaceWith(Routes.verification);
    }
  }

  Widget _buildSignUpButton() => SizedBox(
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

              await _handleSignUp();
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Text("Sign Up"),
          ),
        ),
      );
}
