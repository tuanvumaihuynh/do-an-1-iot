import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/images.dart';

class AvatarImageCustom extends StatelessWidget {
  const AvatarImageCustom(
      {super.key, required this.photoUrl, required this.imageSize});

  final String photoUrl;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return photoUrl == ''
        ? Image(
            image: AppImages.defaultAvatar,
            height: imageSize,
            width: imageSize,
          )
        : CachedNetworkImage(
            imageUrl: photoUrl,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image(
              image: AppImages.defaultAvatar,
              height: imageSize,
              width: imageSize,
            ),
            errorWidget: (context, url, error) => Image(
              image: AppImages.defaultAvatar,
              height: imageSize,
              width: imageSize,
            ),
          );
  }
}
