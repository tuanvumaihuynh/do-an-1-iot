import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class NameTileWidget extends StatelessWidget {
  const NameTileWidget({super.key, required this.homeName});
  final String homeName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.DEFAULT_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            homeName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 15),
        ],
      ),
    );
  }
}
