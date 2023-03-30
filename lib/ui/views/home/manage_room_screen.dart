import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/models/room.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/core/services/unique_id_service.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/name_tile_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageRoomScreen extends StatelessWidget {
  const ManageRoomScreen({super.key});

  Widget editForm(BuildContext context) {
    var editController = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('New room'),
      content: TextFormField(
        controller: editController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: 'Enter room name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            final firebaseDb = FirebaseDatabase.instance.ref();

            final inputValue = editController.text;
            // Show circular loading
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: ((context) => const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.PRIMARY_COLOR))));
            final homeID = context.read<HomeProvider>().selectedHome.id;
            final newRoom = Room(
                id: UniqueIDService.timeBasedID,
                name: inputValue,
                device: null);
            //
            // Update new room into current home
            //
            await firebaseDb
                .child("homes")
                .child(homeID)
                .child("room")
                .update({newRoom.id: newRoom.toJson()});

            await Provider.of<HomeProvider>(context, listen: false)
                .fetchHomeData();

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final selectedHome = homeProvider.selectedHome;
    final roomList = selectedHome.room;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
          showDialog(
            context: context,
            builder: (context) {
              return editForm(context);
            },
          );
        }),
        label: const Text("Add Room"),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Manage rooms',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.DEFAULT_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedHome.name,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF666666),
                    ),
              ),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING,
              ),
              Column(
                children: roomList!.isEmpty
                    ? [
                        const Center(
                            child: Text("You don't have room?? So sad")),
                      ]
                    : roomList
                        .map((room) => NameTileWidget(homeName: room.name))
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
