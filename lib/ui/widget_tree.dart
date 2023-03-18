import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:do_an_1_iot/ui/views/auth/auth_screen.dart';
import 'package:do_an_1_iot/ui/views/auth/verify_email_screen.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const AuthScreen();
          }
        }));
  }
}
