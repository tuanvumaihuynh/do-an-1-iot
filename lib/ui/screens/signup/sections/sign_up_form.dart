import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {super.key,
      required this.formKey,
      required this.nameController,
      required this.emailController,
      required this.passwordController});

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordVisible = false;

  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildUsernameField(),
          const SizedBox(height: AppSizes.defaultPadding),
          _buildEmailField(),
          const SizedBox(height: AppSizes.defaultPadding),
          _buildPasswordField(),
          const SizedBox(height: AppSizes.defaultPadding),
          _buildConfirmPasswordField(),
        ],
      ),
    );
  }

  Widget _buildUsernameField() => TextFormField(
        controller: widget.nameController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          label: const Text('Username'),
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Username can not be blank';
          }

          return null;
        },
      );

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
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
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

  Widget _buildConfirmPasswordField() => TextFormField(
        controller: _confirmPasswordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.darkGrey,
            ),
            onPressed: (() {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
          ),
          label: const Text('Confirm password'),
          hintText: "Confirm password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value != widget.passwordController.text) {
            return 'Password not match';
          }

          return null;
        },
      );
}
