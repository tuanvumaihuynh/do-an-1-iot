import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/ui/screens/home/sections/sliver_header.dart';
import 'package:do_an_1_iot/ui/screens/home/sections/tab_bar_view_body.dart';
import 'package:do_an_1_iot/ui/screens/home/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    final dataProvider = Provider.of<DataProvider>(context);

    final int tabControllerLength = dataProvider.rooms?.length ?? 0;

    if (_tabController == null ||
        tabControllerLength != _tabController?.length) {
      _tabController?.dispose();
      int initialTabIndex = 0;
      if (dataProvider.selectedRoom != null) {
        initialTabIndex =
            dataProvider.rooms?.indexOf(dataProvider.selectedRoom!) ?? 0;
      }

      _tabController = TabController(
          initialIndex: initialTabIndex,
          length: tabControllerLength,
          vsync: this);

      _tabController!.addListener(() {
        dataProvider
            .setSelectedRoom(dataProvider.rooms?[_tabController!.index]);
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final int homeLength = dataProvider.homes?.length ?? 0;

    final int roomLength = dataProvider.rooms?.length ?? 0;

    final List<String>? roomNames = dataProvider.roomNames;

    return SafeArea(
      child: DefaultTabController(
        length: roomLength,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) => <Widget>[
            SliverHeader(tabController: _tabController),
          ],
          body: Column(
            children: [
              const WeatherCard(),
              if (roomNames != null) _buildTabBar(roomNames),
              _buildTabContent(homeLength, roomLength),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(List<String> roomNames) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: _tabController,
            labelPadding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            unselectedLabelColor: Theme.of(context)
                .textTheme
                .labelMedium
                ?.color
                ?.withOpacity(0.3),
            labelColor: Theme.of(context).textTheme.labelMedium?.color,
            indicatorColor: AppColors.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: [
              for (var roomName in roomNames)
                Text(
                  roomName,
                  style: const TextStyle(fontSize: 20),
                )
            ],
          ),
        ),
      );

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
      return Flexible(child: TabBarViewBody(tabController: _tabController));
    }
  }
}
