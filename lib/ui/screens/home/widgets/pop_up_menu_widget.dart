import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpMenuWidget extends StatefulWidget {
  const PopUpMenuWidget({super.key});

  @override
  State<PopUpMenuWidget> createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  List<PopupMenuItem> _popupMenuItemList = [];

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    int? indexSelectedHome = dataProvider.indexSelectedHome;

    List<String>? homeNames = dataProvider.homeNames;

    if (indexSelectedHome != null && homeNames != null) {
      _popupMenuItemList = [
        ..._homePopupItems(dataProvider),
        ..._defaultPopupItems
      ];
    } else {
      _popupMenuItemList = [..._defaultPopupItems];
    }

    return PopupMenuButton(
      initialValue: indexSelectedHome,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: ((value) {}),
      itemBuilder: (context) => _popupMenuItemList,
      child: SizedBox(
        width: 200,
        child: Row(
          children: [
            Flexible(
              child: Text(
                dataProvider.homeNames != null
                    ? dataProvider.selectedHome!.name
                    : "No home",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              size: 25,
              Icons.keyboard_arrow_down_rounded,
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuItem> get _defaultPopupItems {
    const dividerItem = PopupMenuItem(enabled: false, child: Divider());

    final settingItem = PopupMenuItem(
      onTap: (() async {
        // Need to delay here because when this item is on tap, two nav route close in the same time
        await Future.delayed(const Duration(milliseconds: 10));

        await AppNavigator.push(Routes.manageHome);
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Home management",
            overflow: TextOverflow.ellipsis,
          ),
          Icon(Icons.settings)
        ],
      ),
    );

    return [dividerItem, settingItem];
  }

  List<PopupMenuItem> _homePopupItems(DataProvider dataProvider) {
    List<PopupMenuItem> homePopupItems = [];

    final homeNames = dataProvider.homeNames!;

    for (var homeName in homeNames) {
      final int index = homeNames.indexOf(homeName);
      final popUpMenuItem = PopupMenuItem(
        onTap: (() {
          dataProvider.setSelectedHome(dataProvider.homes![index]);

          dataProvider.setSelectedRoom(dataProvider.rooms!.first);
        }),
        value: index,
        child: SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              homeName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

      homePopupItems.add(popUpMenuItem);
    }

    return homePopupItems;
  }
}
