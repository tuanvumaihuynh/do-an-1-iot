import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/sizes.dart';
import '../../widgets/custom_app_bar.dart';

class ControlDeviceScreen extends StatefulWidget {
  const ControlDeviceScreen({super.key});

  @override
  State<ControlDeviceScreen> createState() => _ControlDeviceScreenState();
}

class _ControlDeviceScreenState extends State<ControlDeviceScreen> {
  int index = 0;

  List<Color> colorList = [
    const Color(0xFF33C0BA),
    const Color(0xFF1086D4),
    const Color(0xFF6D04E2),
    const Color(0xFFC421A0),
    const Color(0xFFE4262F),
  ];

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final selectedDevice = dataProvider.selectedDevice!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).backgroundColor,
              colorList[index],
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: Column(
              children: [
                CustomAppBar(title: selectedDevice.name),
                const SizedBox(height: AppSizes.defaultPadding),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (index < 4) {
                        index++;
                      }
                    });
                  },
                  child: Text('Increase'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(index);
                    setState(() {
                      if (index > 0) {
                        index--;
                      }
                    });
                  },
                  child: Text('Decrease'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
