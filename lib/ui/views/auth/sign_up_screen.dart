import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_images.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/constants/app_validators.dart';
import 'package:do_an_1_iot/core/models/user_model.dart';
import 'package:do_an_1_iot/core/services/firebase_auth_service.dart';
import 'package:do_an_1_iot/ui/views/auth/widgets/text_field_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key, required this.onClickedSignIn});
  final VoidCallback onClickedSignIn;
  final _formKey = GlobalKey<FormState>();
  late String _userName, _email, _password;
  final userDatabase = FirebaseDatabase.instance.ref('users');

  Future<void> createUserWithEmailAndPassword(context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) => const Center(
              child:
                  CircularProgressIndicator(color: AppColors.PRIMARY_COLOR))));
      await Auth()
          .createUserWithEmailAndPassword(email: _email, password: _password);
      _pushUserToRTDB();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.message!),
          );
        },
      );
    }
  }

  Future<void> _pushUserToRTDB() async {
    final userModel = UserModel(
        id: Auth().currentUser!.uid,
        name: _userName,
        email: _email,
        phoneNumber: '',
        photoUrl:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        homeIDs: []);

    try {
      await userDatabase.update({userModel.id: userModel.toJson()});
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppImages.BACKGROUND_AUTH,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.DEFAULT_PADDING),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
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
                          const TextFieldName(text: "Username"),
                          TextFormField(
                            decoration:
                                const InputDecoration(hintText: "username"),
                            validator: RequiredValidator(
                                errorText: "Username is required"),
                            onSaved: (username) => _userName = username!,
                          ),
                          const SizedBox(height: AppSizes.DEFAULT_PADDING),
                          const TextFieldName(text: "Email"),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: "test@email.com"),
                            validator:
                                EmailValidator(errorText: "Use a valid email!"),
                            onSaved: (email) => _email = email!,
                          ),
                          const SizedBox(height: AppSizes.DEFAULT_PADDING),
                          const TextFieldName(text: "Password"),
                          TextFormField(
                            obscureText: true,
                            decoration:
                                const InputDecoration(hintText: "********"),
                            validator: AppValidators.passwordValidator,
                            onSaved: (password) => _password = password!,
                            onChanged: (pass) => _password = pass,
                          ),
                          const SizedBox(height: AppSizes.DEFAULT_PADDING),
                          const TextFieldName(text: "Confirm Password"),
                          TextFormField(
                            obscureText: true,
                            decoration:
                                const InputDecoration(hintText: "********"),
                            validator: (pass) => MatchValidator(
                                    errorText: "Password do not match")
                                .validateMatch(pass!, _password),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.DEFAULT_PADDING * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Sign up form is done
                            // It saved our inputs
                            _formKey.currentState!.save();
                            createUserWithEmailAndPassword(context);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Sign Up"),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: onClickedSignIn,
                          child: const Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
