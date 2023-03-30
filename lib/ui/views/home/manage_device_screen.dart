import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_device.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:flutter/material.dart';

class ManageDeviceScreen extends StatefulWidget {
  const ManageDeviceScreen({super.key, required this.homeProvider});
  final HomeProvider homeProvider;

  @override
  State<ManageDeviceScreen> createState() => _ManageDeviceScreenState();
}

class _ManageDeviceScreenState extends State<ManageDeviceScreen> {
  String? selectedRoomName;

  Widget buildGridviewForDevice(List<Map> devices, BuildContext context) {
    final GridView gridView = GridView.count(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 15),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 2.1,
      children:
          devices.map((device) => buildDeviceCard(device, context)).toList(),
    );

    return gridView;
  }

  Widget buildForm(String type) {
    final rooms = widget.homeProvider.selectedHome.room;
    var editController = TextEditingController();

    if (rooms == null || rooms.isEmpty) {
      return const Text("Create a room before creating device");
    }
    selectedRoomName ??= widget.homeProvider.selectedHome.room!.first.name;
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text("Create $type device"),
          content: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Select room:"),
                    const SizedBox(width: 10),
                    DropdownButton(
                      menuMaxHeight: 100,
                      borderRadius: BorderRadius.circular(15),
                      value: selectedRoomName,
                      items: rooms
                          .map((room) => DropdownMenuItem(
                                value: room.name,
                                child: Text(room.name),
                              ))
                          .toList(),
                      onChanged: ((value) {
                        setState(() {
                          selectedRoomName = value;
                        });
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.DEFAULT_PADDING),
                TextFormField(
                  controller: editController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    labelText: 'Enter device name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Show circular loading
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: ((context) => const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.PRIMARY_COLOR))));

                FocusScope.of(context).unfocus();

                final inputValue = editController.text;

                final json =
                    widget.homeProvider.createDeviceJson(type, inputValue);

                await widget.homeProvider.pushDeviceDataIntoRTDB(
                    rooms
                        .firstWhere((room) => room.name == selectedRoomName)
                        .id,
                    json);

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("Create"),
            )
          ],
        );
      },
    );
  }

  Widget buildDeviceCard(Map item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context, builder: (context) => buildForm(item["type"]));
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Image.asset(
                item["image"],
                fit: BoxFit.fill,
                height: 40,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  item["name"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF666666)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedRoomName);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add device',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.DEFAULT_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // Bluetooh connect section
              //

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bluetooth,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Auto-detecting nearby devices",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF666666),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.DEFAULT_PADDING * 3),
              Center(
                child: Image.asset("assets/images/iphone.png", height: 150),
              ),
              const SizedBox(height: AppSizes.DEFAULT_PADDING),
              const Center(
                child: Text(
                  "Place the phone as close to the target device as possible",
                  style: TextStyle(fontSize: 12),
                ),
              ),

              //
              // Divider section
              //

              const Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppSizes.DEFAULT_PADDING * 2),
                child: Divider(),
              ),

              //
              // Add manually section
              //

              Text(
                "Add devices manually",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF666666),
                    ),
              ),

              //
              //  Lighting section
              //

              const SizedBox(
                height: AppSizes.DEFAULT_PADDING * 1.5,
              ),
              const Text(
                "Lighting",
              ),
              buildGridviewForDevice(AppDevice.lightingDevices, context),

              //
              //  Air treatment section
              //

              const SizedBox(
                height: AppSizes.DEFAULT_PADDING,
              ),
              const Text(
                "Air treatment",
              ),
              buildGridviewForDevice(AppDevice.airTreatmentDevices, context),
            ],
          ),
        ),
      ),
    );
  }
}
