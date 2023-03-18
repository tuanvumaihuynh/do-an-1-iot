import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_images.dart';
import 'package:flutter/material.dart';

class PhotoViewWidget extends StatelessWidget {
  const PhotoViewWidget({super.key, required this.photoUrl});
  final String photoUrl;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: CachedNetworkImage(
            imageUrl: photoUrl,
            height: width,
            width: width,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const CircularProgressIndicator(color: AppColors.PRIMARY_COLOR),
            errorWidget: ((context, url, error) => Image.asset(
                  AppImages.DEFAULT_AVATAR,
                  height: width,
                  width: width,
                ))),
      ),
    );
  }
}
