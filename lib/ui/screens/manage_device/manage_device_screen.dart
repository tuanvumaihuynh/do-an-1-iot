import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/ui/screens/manage_device/sections/device_section.dart';
import 'package:do_an_1_iot/ui/screens/manage_device/widgets/bluetooth_view_widget.dart';
import 'package:do_an_1_iot/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';

class ManageDeviceScreen extends StatelessWidget {
  const ManageDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'Add Device'),
                const SizedBox(height: AppSizes.defaultPadding),
                const BluetoothViewWidget(),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.defaultPadding * 2),
                  child: Divider(),
                ),
                Text(
                  "Add devices manually",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: const Color(0xFF666666),
                      ),
                ),
                const SizedBox(height: AppSizes.defaultPadding),
                const DeviceSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
