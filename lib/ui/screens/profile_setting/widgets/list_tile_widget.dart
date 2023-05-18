import 'package:do_an_1_iot/ui/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sizes.dart';
import '../../../../routes.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/realtime_database_service.dart';
import '../../../widgets/custom_dialog.dart';

class ListTileWidget extends StatefulWidget {
  const ListTileWidget({
    super.key,
    required this.title,
    required this.data,
    this.canEdited = false,
  });

  final bool canEdited;
  final String title;
  final String data;

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
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
    return InkWell(
      onLongPress: !widget.canEdited
          ? null
          : () {
              ModalBottomSheetCustom.showWithTextField(
                context,
                _formKey,
                widget.title,
                _textController,
                onSubmit: () async {
                  _handlePushData(
                      widget.title, _formKey, _textController.text.trim());
                },
              );
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Expanded(
                child: Text(
              widget.data,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF999999),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _handlePushData(
      String title, GlobalKey<FormState> formKey, String data) async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); //to hide the keyboard

      formKey.currentState!.save(); // It saved our inputs

      // Pop modal bottom sheet
      AppNavigator.pop();

      // Show dialog loading
      CustomDialog.showLoadingDialog(context);

      // Path
      final String path = 'users/${AuthService.currentUser!.uid}';

      // Update data
      await RealtimeDatabaseService.updateData(path, {_getPath(title): data});
      // Pop loading dialog
      AppNavigator.pop();
    }
  }

  String _getPath(String title) {
    switch (title) {
      case 'Name':
        return 'name';
      case 'Email':
        return 'email';
      case 'Phone number':
        return 'phone_number';
      default:
        return '';
    }
  }
}
