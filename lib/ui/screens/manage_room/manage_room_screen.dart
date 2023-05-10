import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/ui/widgets/home_tile_widget.dart';
import 'package:do_an_1_iot/ui/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';
import '../../widgets/custom_dialog.dart';

class ManageRoomScreen extends StatefulWidget {
  const ManageRoomScreen({super.key});

  @override
  State<ManageRoomScreen> createState() => _ManageRoomScreenState();
}

class _ManageRoomScreenState extends State<ManageRoomScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    final List<String>? roomNames = dataProvider.roomNames;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Fix when no input submit
          ModalBottomSheetCustom.showWithTextField(
              context, _formKey, 'Room', _textController, onSubmit: () {
            // Pop modal bottom sheet
            AppNavigator.pop();

            // Show loading dialog
            CustomDialog.showLoadingDialog(context);

            // Create room
            dataProvider.createRoom(_textController.text.trim());

            // Pop loading dialog
            AppNavigator.pop();

            // Pop room management screen
            AppNavigator.pop();
          });
        },
        label: const Text('Add room'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: (() {
              AppNavigator.pop();
            }),
            child: const Icon(Icons.arrow_back, color: Colors.black)),
        title: Text(
          'Room management',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My room',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF666666),
                    ),
              ),
              const SizedBox(height: AppSizes.defaultPadding),
              roomNames == null
                  ? const Center(child: Text("No room founded"))
                  : Column(
                      children: roomNames
                          .map((roomName) => CustomTileWidget(title: roomName))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
