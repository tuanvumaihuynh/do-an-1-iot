import 'package:do_an_1_iot/constants/images.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:flutter/material.dart';

class BluetoothViewWidget extends StatelessWidget {
  const BluetoothViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bluetooth,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              "Auto-detecting nearby devices",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF666666),
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.defaultPadding),
        const Center(
          child: Image(
            image: AppImages.iphone,
            height: 200,
          ),
        ),
        const SizedBox(height: AppSizes.defaultPadding),
        const Center(
          child: Text(
            "Place the phone as close to the target device as possible",
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
