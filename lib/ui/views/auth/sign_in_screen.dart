import 'package:do_an_1_iot/constants/app_images.dart';
import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/constants/app_validators.dart';
import 'package:do_an_1_iot/core/services/firebase_auth_service.dart';
import 'package:do_an_1_iot/ui/views/auth/forgot_password_screen.dart';
import 'package:do_an_1_iot/ui/views/auth/widgets/text_field_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key, required this.onClickedSignUp});
  final VoidCallback onClickedSignUp;
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  Future<void> signInWithEmailAndPassword(context) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: ((context) => const Center(
    //         child: CircularProgressIndicator(color: AppColors.PRIMARY_COLOR))));
    try {
      await Auth()
          .signInWithEmailAndPassword(email: _email, password: _password);

      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(e.message ?? 'No error'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(AppImages.BACKGROUND_AUTH, fit: BoxFit.cover),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SafeArea(
                    child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.DEFAULT_PADDING),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSizes.DEFAULT_PADDING * 2),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextFieldName(text: "Email"),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: "test@email.com"),
                              validator: AppValidators.emailValidator,
                              onSaved: (email) {
                                _email = email!;
                              },
                            ),
                            const SizedBox(height: AppSizes.DEFAULT_PADDING),
                            const TextFieldName(text: "Password"),
                            TextFormField(
                              // Hide password
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: "********"),
                              validator: AppValidators.passwordValidator,
                              onSaved: (password) {
                                _password = password!;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.DEFAULT_PADDING * 2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              // backgroundColor: const Color(0xFF6CD8D1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // It saved our inputs
                              _formKey.currentState!.save();

                              signInWithEmailAndPassword(context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text("Sign In"),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.DEFAULT_PADDING),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(AppRoute.fadeInAnimation(
                              const ForgotPasswordScreen()));
                        },
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                              color: Colors.black54,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: onClickedSignUp,
                            child: const Text(
                              "Sign Up!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )))
          ],
        ));
  }
}
