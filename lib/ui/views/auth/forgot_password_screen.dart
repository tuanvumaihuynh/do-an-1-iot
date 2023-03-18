import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/constants/app_validators.dart';
import 'package:do_an_1_iot/core/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          title: const Text('Reset Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your email",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSizes.DEFAULT_PADDING),
                  TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: AppValidators.emailValidator),
                  const SizedBox(height: AppSizes.DEFAULT_PADDING),
                  ElevatedButton.icon(
                      onPressed: (() {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          resetPassword();
                        }
                      }),
                      icon: const Icon(Icons.email_outlined),
                      label: const Text('Reset Password'))
                ],
              )),
        ));
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) =>
            const Center(child: CircularProgressIndicator())));
    try {
      await Auth().resetPassword(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
