import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/ui/views/home/manage_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupMenuWidget extends StatefulWidget {
  const PopupMenuWidget({super.key});

  @override
  State<PopupMenuWidget> createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  int _selectedIndex = 0;

  List<PopupMenuItem> popupMenuItemList = [];

  List<PopupMenuItem> listPopUpItemConvert(List<String> homeNameList) {
    List<PopupMenuItem> listWidget = [];
    for (var homeName in homeNameList) {
      final popUpMenuItem = PopupMenuItem(
          value: homeNameList.indexOf(homeName),
          child: SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                homeName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ));

      listWidget.insert(0, popUpMenuItem);
    }
    return listWidget;
  }

  List<PopupMenuItem> get listDefaultPopUpItem {
    const dividerItem = PopupMenuItem(enabled: false, child: Divider());
    final settingItem = PopupMenuItem(
        // TODO: Define setting home here
        onTap: (() async {
          //! Need to delay here because when this item is on tap, two nav route close in the same time
          await Future.delayed(const Duration(milliseconds: 10));
          Navigator.of(context)
              .push(AppRoute.fadeInAnimation(const ManageHomeScreen()));
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
        ));

    return [dividerItem, settingItem];
  }

  @override
  Widget build(BuildContext context) {
    final homeList = context.watch<HomeProvider>().getHomeList;
    print("Home Length: ${homeList?.length}");

    List<String> homeNameList =
        homeList != null ? [for (var home in homeList) home.name] : [];

    popupMenuItemList = [
      ...listPopUpItemConvert(homeNameList),
      ...listDefaultPopUpItem
    ];
    return PopupMenuButton(
        position: PopupMenuPosition.under,
        initialValue: _selectedIndex,
        onSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: ((context) {
          return popupMenuItemList;
        }),
        child: SizedBox(
          width: 200,
          child: Row(
            children: [
              Flexible(
                child: Text(
                  homeNameList.isNotEmpty
                      ? homeNameList[_selectedIndex]
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
        ));
  }
}
