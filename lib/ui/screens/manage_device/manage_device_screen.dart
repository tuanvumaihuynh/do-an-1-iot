import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/ui/screens/manage_device/sections/device_section.dart';
import 'package:do_an_1_iot/ui/screens/manage_device/widgets/bluetooth_view_widget.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';

class ManageDeviceScreen extends StatelessWidget {
  const ManageDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: (() {
              AppNavigator.pop();
            }),
            child: const Icon(Icons.arrow_back, color: Colors.black)),
        title: Text(
          'Add device',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BluetoothViewWidget(),
              const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppSizes.defaultPadding * 2),
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
      );
}
