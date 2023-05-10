import 'package:do_an_1_iot/ui/screens/home/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/sizes.dart';
import '../../../../providers/data_provider.dart';

class TabBarHeader extends StatefulWidget {
  const TabBarHeader({super.key});

  @override
  State<TabBarHeader> createState() => _TabBarHeaderState();
}

class _TabBarHeaderState extends State<TabBarHeader> {
  bool _isInit = true;
  late TabController _tabController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final dataProvider = Provider.of<DataProvider>(context);
      print('tabbarHeader init');
      _tabController = DefaultTabController.of(context)!;

      _tabController.addListener(() {
        dataProvider.setSelectedRoom(dataProvider.rooms![_tabController.index]);

        print(dataProvider.selectedRoom!.name);
      });

      setState(() {
        _isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _SliverAppBarDelegate(
        widget: const TabBarWidget(),
      ),
    );
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
