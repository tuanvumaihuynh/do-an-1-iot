import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder<Widget> {
  FadeRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) =>
                  FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget page;
}
