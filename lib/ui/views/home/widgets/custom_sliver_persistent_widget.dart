import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomSliverPersistentWidget extends SliverPersistentHeaderDelegate {
  final Widget widget;
  CustomSliverPersistentWidget({required this.widget});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.DEFAULT_PADDING),
      child: SizedBox(
        height: 50,
        child: widget,
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
