import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/constants/app_images.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/ui/widget_tree.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      // SvgPicture.asset('assets/icons/android12splash.png', fit: BoxFit.cover),
      SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.DEFAULT_PADDING),
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset(AppImages.LOGO),
            // TODO: Fix App name, theme.of(context)
            Text(
              "App name",
              style: Theme.of(context).textTheme.headline4,
            ),
            const Spacer(),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .push(AppRoute.fadeInAnimation(const WidgetTree())),
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('Start'),
                  ),
                )),
            const SizedBox(height: 10),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context)
            //           .push(AppRoute.createRoute(SignUpScreen()));
            //     },
            //     style: TextButton.styleFrom(
            //         elevation: 0,
            //         backgroundColor: Colors.transparent,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             side: const BorderSide(color: Color(0xFF6CD8D1)))),
            //     child: const Padding(
            //       padding: EdgeInsets.all(15),
            //       child: Text('Sign Up'),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 100),
          ],
        ),
      ))
    ]));
  }
}
