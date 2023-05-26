import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/data/device_data.dart';
import 'package:do_an_1_iot/ui/screens/manage_device/widgets/device_card_widget.dart';
import 'package:flutter/material.dart';

class DeviceSection extends StatelessWidget {
  const DeviceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildDeviceSection(context),
    );
  }

  List<Widget> _buildDeviceSection(BuildContext context) {
    List<Widget> result = [];

    DeviceData.devices.forEach((key, value) {
      result.addAll([
        const SizedBox(height: AppSizes.defaultPadding),
        Text(key),
        _buildGridView(context, value),
      ]);
    });
    return result;
  }

  Widget _buildGridView(BuildContext context, List<Device> devices) {
    List<Widget> cards = [];

    for (var device in devices) {
      cards.add(DeviceCardWidget(device: device));
    }

    return GridView.count(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 15),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      children: cards,
    );
  }
}
