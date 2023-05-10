import 'package:do_an_1_iot/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/sizes.dart';
import '../../../../providers/data_provider.dart';

class TabBarHeader extends StatelessWidget {
  const TabBarHeader({super.key, required this.tabController});

  final TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
        builder: (BuildContext context, dataProvider, _) {
      final List<RoomModel>? rooms = dataProvider.rooms;

      final List<String>? roomNames =
          rooms == null ? null : [for (var room in rooms) room.name];

      // print(roomNames);

      return SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: _SliverAppBarDelegate(
          widget: TabBar(
            controller: tabController,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
            unselectedLabelColor: const Color(0xFF958B8A),
            labelColor: const Color(0xFF4A4444),
            isScrollable: true,
            tabs: _buildRoomTabs(roomNames!),
          ),
        ),
      );
    });
  }

  List<Widget> _buildRoomTabs(List<String> roomNames) {
    return [for (var roomName in roomNames) Text(roomName)];
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  _SliverAppBarDelegate({required this.widget});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      child: widget,
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
