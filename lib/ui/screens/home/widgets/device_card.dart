import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/models/device_model.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.device});
  final DeviceModel device;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    const double paddingSize = AppSizes.defaultPadding;

    return GestureDetector(
      onTap: (() {}),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              paddingSize, paddingSize, paddingSize, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                device.imagePath,
                height: 50,
                fit: BoxFit.contain,
              ),
              Text(device.name),
              Row(
                children: [
                  const Spacer(),
                  FlutterSwitch(
                    height: 30,
                    width: 50,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Theme.of(context).scaffoldBackgroundColor,
                    value: device.state,
                    onToggle: (state) async {
                      await dataProvider
                          .updateDeviceData(device.id, {'state': state});
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
