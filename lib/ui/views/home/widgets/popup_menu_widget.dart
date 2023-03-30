import 'package:do_an_1_iot/constants/app_colors.dart';
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
          // Need to delay here because when this item is on tap, two nav route close in the same time
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
    final homeProvider = context.watch<HomeProvider>();
    int selectedIndex = homeProvider.indexSelectedhome;

    final homeList = homeProvider.homeList;

    List<String> homeNames = [for (var home in homeList!) home.name];

    popupMenuItemList = [
      ...listPopUpItemConvert(homeNames),
      ...listDefaultPopUpItem
    ];
    return PopupMenuButton(
        position: PopupMenuPosition.under,
        initialValue: selectedIndex,
        onSelected: (value) async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: ((context) => const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.PRIMARY_COLOR))));

          await homeProvider.cancelHomeStreamSubcription();

          homeProvider.setIndexSelectedHome(value);
          await homeProvider.startListeningToHomeChangesInRTDB();

          Navigator.of(context).pop();
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
                  homeNames.isNotEmpty ? homeNames[selectedIndex] : "No home",
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
