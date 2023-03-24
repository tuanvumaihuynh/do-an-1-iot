import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/models/home.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:do_an_1_iot/core/services/unique_id_service.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/home_tile_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageHomeScreen extends StatelessWidget {
  const ManageHomeScreen({super.key});

  Widget editForm(BuildContext context) {
    var editController = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('New home'),
      content: TextFormField(
        controller: editController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: 'Enter home name',
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
            final uid = UserProvider.currentUser!.uid;
            final newHome = Home(
                id: UniqueIDService.timeBasedID,
                name: inputValue,
                roomIDs: null);

            // Update new home into user info
            await firebaseDb
                .child("users")
                .child(uid)
                .child("homeIDs")
                .update({newHome.id: true});
            // Add new home data into database
            await firebaseDb
                .child("homes")
                .child(newHome.id)
                .update(newHome.toJson());
            // Fetch home data again
            await Provider.of<HomeProvider>(context, listen: false)
                .fetchHomeData();
            print(HomeProvider().getHomeList);

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
    final homeList = context.watch<HomeProvider>().getHomeList;
    List<String> homeNameList =
        homeList != null ? [for (var home in homeList) home.name] : [];
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
        label: const Text("Add Home"),
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
            'Manage homes',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.DEFAULT_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My family',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF666666),
                    ),
              ),
              const SizedBox(
                height: AppSizes.DEFAULT_PADDING,
              ),
              Column(
                children: homeNameList.isEmpty
                    ? [
                        const Center(
                            child: Text("You don't have home?? So sad")),
                      ]
                    : homeNameList
                        .map((e) => HomeTileWidget(homeName: e))
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
