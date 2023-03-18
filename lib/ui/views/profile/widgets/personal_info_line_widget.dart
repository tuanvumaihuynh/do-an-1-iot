import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';

class PersonalInfoLineWidget extends StatelessWidget {
  PersonalInfoLineWidget(
      {super.key,
      required this.title,
      required this.data,
      canEdited = false,
      uid})
      : _canEdited = canEdited,
        _uid = uid;
  final bool _canEdited;
  final String title;
  String data;
  final String? _uid;

  Widget editForm(BuildContext context) {
    var editController = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Edit $title'),
      content: TextFormField(
        controller: editController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: title,
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
            final userDatabase = FirebaseDatabase.instance.ref('users');
            final typeEditing = _checkTypeEditing();
            final value = editController.text;

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: ((context) => const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.PRIMARY_COLOR))));
            await userDatabase.child(_uid!).update({typeEditing: value});
            data = value;
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        )
      ],
    );
  }

  String _checkTypeEditing() {
    if (title == 'Name') {
      return 'displayName';
    } else if (title == 'Phone number') {
      return 'phoneNumber';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_canEdited) {
      return InkWell(
        onLongPress: (() {
          showDialog(
            context: context,
            builder: (context) {
              return editForm(context);
            },
          );
        }),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppSizes.DEFAULT_PADDING),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  data,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF999999),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSizes.DEFAULT_PADDING / 2,
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.DEFAULT_PADDING),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Expanded(
              child: Text(
                data,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFF999999),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
