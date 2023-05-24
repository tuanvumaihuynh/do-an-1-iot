import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/ui/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../constants/sizes.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<DataProvider>(context).userModel;

    return GestureDetector(
      onTap: (() async {
        await AppNavigator.push(Routes.profileSetting);
      }),
      child: Padding(
        padding: const EdgeInsets.only(left: AppSizes.defaultPadding / 2),
        child: Row(
          children: [
            ClipOval(
              child: AvatarImageCustom(
                  photoUrl: userModel!.photoUrl!, imageSize: 50),
            ),
            const SizedBox(width: AppSizes.defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    userModel.email,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.secondaryColor, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
