import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class ModalBottomSheetCustom {
  static void show(BuildContext context, String title,
      {required VoidCallback onSubmit}) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        enableDrag: true,
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;

          final roomName =
              Provider.of<DataProvider>(context).selectedRoom!.name;

          return SizedBox(
            height: size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create $title in $roomName?',
                    maxLines: 2,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: AppSizes.defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: () {
                            AppNavigator.pop();
                          },
                          style: TextButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.lightGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: AppColors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: onSubmit,
                          style: TextButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text('OK')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showWithTextField(
      BuildContext context,
      GlobalKey<FormState> formKey,
      String title,
      TextEditingController textController,
      {required VoidCallback onSubmit}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (context) => CustomModalBottomSheet(
              title: title,
              formKey: formKey,
              textController: textController,
              function: onSubmit,
            ));
  }
}

class CustomModalBottomSheet extends StatelessWidget {
  const CustomModalBottomSheet({
    super.key,
    required this.title,
    required this.formKey,
    required this.textController,
    required this.function,
  });

  final String title;
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      // height: size.height * 0.3 + keyboardHeight,
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Set $title',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSizes.defaultPadding * 2),
              TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  label: Text(title),
                  hintText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '$title can not be blank';
                  }

                  return null;
                },
              ),
              const SizedBox(height: AppSizes.defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.35,
                    child: ElevatedButton(
                      onPressed: () {
                        AppNavigator.pop();
                      },
                      style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.lightGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.35,
                    child: ElevatedButton(
                      onPressed: function,
                      style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text('OK')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
