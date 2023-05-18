import 'package:do_an_1_iot/ui/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

import '../../constants/images.dart';

class CustomDialog {
  static const double _splashIconSize = 70;

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Image(
          image: AppImages.pikloader,
          height: _splashIconSize,
          width: _splashIconSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static void showImageDialog(BuildContext context, String photoUrl) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: AvatarImageCustom(photoUrl: photoUrl, imageSize: 300),
      ),
    );
  }
}
