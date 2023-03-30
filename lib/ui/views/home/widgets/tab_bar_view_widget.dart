import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/models/device.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:provider/provider.dart';

class TabBarViewWidget extends StatelessWidget {
  const TabBarViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final roomList = homeProvider.selectedHome.room;

    Widget buildDeviceCard(Device device, String roomID) {
      // print(device.toJson());
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                device.image,
                fit: BoxFit.fill,
                height: 50,
              ),
              Text(
                device.name,
                style: const TextStyle(fontSize: 15),
              ),
              Row(
                children: [
                  const Spacer(),
                  FlutterSwitch(
                    width: 50,
                    height: 30,
                    value: device.state,
                    activeColor: AppColors.PRIMARY_COLOR,
                    inactiveColor: Colors.black12,
                    onToggle: (value) async {
                      await homeProvider.updateStateDevice(
                          value, device.id, roomID);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Return GridView List for room List
    // Don't I need Streambuilder
    // StreamSubcription?
    Widget buildRoomPage(List<Device>? devices, String roomID) {
      if (devices == null || devices.isEmpty) {
        return const Center(child: Text("No device founded"));
      }

      final GridView gridView = GridView.count(
        primary: false,
        padding: const EdgeInsets.only(top: 45),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        children:
            devices.map((device) => buildDeviceCard(device, roomID)).toList(),
      );

      return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.DEFAULT_PADDING),
        child: gridView,
      );
    }

    /// This method build room page with devices belong to this room.
    /// Using Streambuilder to catch event realtime
    /// Create some method to push data in RTDB
    List<Widget> roomTabBarViewList() {
      final widgetList =
          roomList!.map((room) => buildRoomPage(room.device, room.id)).toList();

      return widgetList;
    }

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      children: roomTabBarViewList(),
    );
  }
}
