import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return PageView(
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
    );
  }
}
