import 'package:do_an_1_iot/data/device_data.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/ui/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/sizes.dart';

class DeviceCardWidget extends StatelessWidget {
  const DeviceCardWidget({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        ModalBottomSheetCustom.show(context, device.name, onSubmit: () async {
          await _handleCreateDevice(dataProvider);
          AppNavigator.pop();
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                device.imagePath,
                height: 50,
              ),
              Expanded(
                child: Text(
                  device.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF666666)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleCreateDevice(DataProvider dataProvider) async {
    await dataProvider.createDevice(device);
  }
}
