import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/ui/widgets/custom_dialog.dart';
import 'package:do_an_1_iot/ui/widgets/home_tile_widget.dart';
import 'package:do_an_1_iot/ui/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';

class ManageHomeScreen extends StatefulWidget {
  const ManageHomeScreen({super.key});

  @override
  State<ManageHomeScreen> createState() => _ManageHomeScreenState();
}

class _ManageHomeScreenState extends State<ManageHomeScreen> {
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

    final List<String>? homeNames = dataProvider.homeNames;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Fix when no input submit
          ModalBottomSheetCustom.showWithTextField(
              context, _formKey, 'Home', _textController, onSubmit: () async {
            // Pop modal bottom sheet
            AppNavigator.pop();

            // Show loading dialog
            CustomDialog.showLoadingDialog(context);

            // Create home
            await dataProvider.createHome(_textController.text.trim());

            // Pop loading dialog
            AppNavigator.pop();
          });
        },
        label: const Text('Add home'),
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
          'Home management',
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
                'My home',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF666666),
                    ),
              ),
              const SizedBox(height: AppSizes.defaultPadding),
              homeNames == null
                  ? const Center(child: Text("No home founded"))
                  : Column(
                      children: homeNames
                          .map((homeName) => CustomTileWidget(title: homeName))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
