import 'package:do_an_1_iot/constants/images.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double splashIconSize = 70;
    return const Scaffold(
      body: Center(
          child: Image(
        image: AppImages.pikloader,
        width: splashIconSize,
        height: splashIconSize,
        fit: BoxFit.contain,
      )),
    );
  }
}
