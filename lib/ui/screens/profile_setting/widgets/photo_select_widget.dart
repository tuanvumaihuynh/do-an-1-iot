import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/colors.dart';

class PhotoSelectWidget extends StatelessWidget {
  const PhotoSelectWidget({super.key, required this.onTap});

  final Function(BuildContext context, ImageSource source) onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Pick image from',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          ElevatedButton.icon(
            onPressed: () => onTap(context, ImageSource.camera),
            icon: const Icon(Icons.camera),
            label: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Camera'),
            ),
            style: TextButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          ElevatedButton.icon(
            onPressed: () => onTap(context, ImageSource.gallery),
            icon: const Icon(Icons.image),
            label: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Photo Library'),
            ),
            style: TextButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }
}
