import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final List<String>? roomNames = dataProvider.roomNames;

    return TabBar(
      labelPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      unselectedLabelColor: const Color(0xFF958B8A),
      labelColor: const Color(0xFF4A4444),
      isScrollable: true,
      tabs: _buildRoomTabs(roomNames!),
    );
  }

  List<Widget> _buildRoomTabs(List<String> roomNames) => roomNames
      .map(
        (roomName) => Tab(
          child: Text(
            roomName,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      )
      .toList();
}
