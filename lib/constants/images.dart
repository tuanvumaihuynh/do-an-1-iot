// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const AssetImage defaultDevice = _Image('device.png');
  static const AssetImage defaultAvatar = _Image('avatar.png');
  static const AssetImage iphone = _Image('iphone.png');
  static const AssetImage pikloader = _Image('pika_loader.gif');
  static const AssetImage logo = _Image('android12splash_old.png');
  static const AssetImage googleIcon = _Image('google_icon.png');

  static Future<void> precacheAssets(BuildContext context) async {
    await precacheImage(defaultDevice, context);
    await precacheImage(defaultAvatar, context);
    await precacheImage(iphone, context);
    await precacheImage(pikloader, context);
    await precacheImage(logo, context);
    await precacheImage(googleIcon, context);
  }
}
