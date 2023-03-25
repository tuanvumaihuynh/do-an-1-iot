import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.DEFAULT_PADDING),
      child: PageView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: const [
          Center(
            child: Text("First page"),
          ),
          Center(
            child: Text("Second page"),
          ),
          Center(
            child: Text("Third page"),
          ),
        ],
      ),
    );
  }
}
