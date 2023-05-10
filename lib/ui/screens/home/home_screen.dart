import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/ui/screens/home/sections/sliver_header.dart';
import 'package:do_an_1_iot/ui/screens/home/sections/tab_bar_header.dart';
import 'package:do_an_1_iot/ui/screens/home/sections/tab_bar_view_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final int homeLength = dataProvider.homes?.length ?? 0;

    final int roomLength = dataProvider.rooms?.length ?? 0;

    return SafeArea(
      child: DefaultTabController(
        length: roomLength,
        child: NestedScrollView(
            headerSliverBuilder: (context, _) => <Widget>[
                  const SliverHeader(),
                  if (roomLength != 0) const TabBarHeader(),
                ],
            body: _buildTabContent(homeLength, roomLength)),
      ),
    );
  }

  Widget _buildTabContent(int homeLength, int roomLength) {
    if (homeLength == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No home founded'),
          const SizedBox(height: AppSizes.defaultPadding),
          OutlinedButton(
            onPressed: () async {
              AppNavigator.push(Routes.manageHome);
            },
            child: const Text('Create new'),
          )
        ],
      );
    }
    if (roomLength == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No room founded'),
          const SizedBox(height: AppSizes.defaultPadding),
          OutlinedButton(
            onPressed: () async {
              AppNavigator.push(Routes.manageRoom);
            },
            child: const Text('Create new'),
          )
        ],
      );
    } else {
      return const TabBarViewBody();
    }
  }
}
