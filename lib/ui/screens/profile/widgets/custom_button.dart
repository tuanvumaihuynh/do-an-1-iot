import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.iconData,
    required this.text,
    this.onTap,
    vertical,
    horizontal,
  })  : _topLeft = vertical ?? 0,
        _topRight = vertical ?? 0,
        _bottomLeft = horizontal ?? 0,
        _bottomRight = horizontal ?? 0;
  final IconData iconData;
  final String text;
  final double _topLeft;
  final double _topRight;
  final double _bottomLeft;
  final double _bottomRight;
  final VoidCallback? onTap;

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
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: AppColors.primaryColor,
                size: 25,
              ),
              const SizedBox(
                width: AppSizes.defaultPadding,
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
                color: AppColors.primaryColor,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
