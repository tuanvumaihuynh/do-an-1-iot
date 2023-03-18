import 'package:flutter/material.dart';
import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';

class SubContentProfileWidget extends StatelessWidget {
  const SubContentProfileWidget({
    super.key,
    required this.iconData,
    required this.text,
    top,
    bottom,
  })  : _topLeft = top ?? 0,
        _topRight = top ?? 0,
        _bottomLeft = bottom ?? 0,
        _bottomRight = bottom ?? 0;
  final IconData iconData;
  final String text;
  final double _topLeft;
  final double _topRight;
  final double _bottomLeft;
  final double _bottomRight;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_topLeft),
          topRight: Radius.circular(_topRight),
          bottomLeft: Radius.circular(_bottomLeft),
          bottomRight: Radius.circular(_bottomRight)),
      child: InkWell(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_topLeft),
            topRight: Radius.circular(_topRight),
            bottomLeft: Radius.circular(_bottomLeft),
            bottomRight: Radius.circular(_bottomRight)),
        onTap: (() {}),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.DEFAULT_PADDING),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: AppColors.PRIMARY_COLOR,
                size: 25,
              ),
              const SizedBox(
                width: AppSizes.DEFAULT_PADDING,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.PRIMARY_COLOR,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
