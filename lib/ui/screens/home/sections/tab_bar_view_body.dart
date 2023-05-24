import 'package:do_an_1_iot/models/room_model.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/ui/screens/home/widgets/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/sizes.dart';
import '../../../../routes.dart';

class TabBarViewBody extends StatelessWidget {
  const TabBarViewBody({super.key, required this.tabController});

  final TabController? tabController;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return TabBarView(
      controller: tabController,
      children: _roomPages(dataProvider),
    );
  }

  List<Widget> _roomPages(DataProvider dataProvider) =>
      dataProvider.rooms!.map((room) {
        return _buildRoomPage(dataProvider, room);
      }).toList();

  Widget _buildRoomPage(DataProvider dataProvider, RoomModel roomModel) {
    final devices = roomModel.devices;

    if (devices == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No device founded'),
          const SizedBox(height: AppSizes.defaultPadding),
          OutlinedButton(
            onPressed: () async {
              AppNavigator.push(Routes.manageDevice);
            },
            child: const Text('Create new'),
          )
        ],
      );
    }

    return SingleChildScrollView(
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.only(top: AppSizes.defaultPadding),
              children: devices
                  .map((device) => DeviceCard(
                        device: device,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSizes.defaultPadding),
          OutlinedButton(
            onPressed: () async {
              await AppNavigator.push(Routes.manageDevice);
            },
            child: const Text('Edit'),
          )
        ],
      ),
    );
  }
}
