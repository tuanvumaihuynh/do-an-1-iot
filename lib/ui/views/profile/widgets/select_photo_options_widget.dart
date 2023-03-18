import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectPhotoOptionsWidget extends StatelessWidget {
  const SelectPhotoOptionsWidget({super.key, required this.onTap});
  final Function(ImageSource source, BuildContext context) onTap;

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
            onPressed: () => onTap(ImageSource.camera, context),
            icon: const Icon(Icons.camera),
            label: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Camera'),
            ),
            style: TextButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: AppColors.PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          ElevatedButton.icon(
            onPressed: () => onTap(ImageSource.gallery, context),
            icon: const Icon(Icons.image),
            label: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Photo Library'),
            ),
            style: TextButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: AppColors.PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }
}
