import 'package:do_an_1_iot/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/sizes.dart';

class SignInForm extends StatefulWidget {
  const SignInForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: AppSizes.defaultPadding),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildEmailField() => TextFormField(
        controller: widget.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          label: const Text('Email'),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email can not be blank';
          }
          if (!value.contains("@") && !value.contains(".com")) {
            return 'Invalid email format';
          }
          return null;
        },
      );

  Widget _buildPasswordField() => TextFormField(
        controller: widget.passwordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: AppColors.darkGrey,
            ),
            onPressed: (() {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
          ),
          label: const Text('Password'),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password can not be blank';
          }
          if (value.length < 6) {
            return 'Password need more than 6 characters';
          }
          return null;
        },
      );
}
