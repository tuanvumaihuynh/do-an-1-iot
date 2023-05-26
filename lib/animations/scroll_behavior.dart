import 'package:flutter/material.dart';

///
/// Android 12’s stretch effect
///
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
        axisDirection: details.direction, child: child);
  }
}
