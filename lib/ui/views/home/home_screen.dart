import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/constants/app_scroll.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/ui/views/home/manage_device_screen.dart';
import 'package:do_an_1_iot/ui/views/home/manage_room_screen.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/custom_sliver_persistent_widget.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/tab_bar_view_widget.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/popup_menu_widget.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/room_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final selectedHome = homeProvider.selectedHome;
    final roomLength = selectedHome.room!.length;

    return roomLength == 0
        ? SafeArea(
            child: DefaultTabController(
              length: roomLength,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    floating: false,
                    backgroundColor: const Color(0xFFF7F7F7),
                    expandedHeight: 50,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.DEFAULT_PADDING,
                        ),
                        child: Row(
                          children: [
                            const PopupMenuWidget(),
                            const Spacer(),
                            const Icon(
                              Icons.notifications_none_outlined,
                              size: 25,
                              color: Color(0xFF2F2B2A),
                            ),
                            const SizedBox(width: AppSizes.DEFAULT_PADDING),
                            InkWell(
                              onTap: (() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Create room before create device")));
                              }),
                              child: const Icon(
                                Icons.add,
                                size: 30,
                                color: Color(0xFF2F2B2A),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "No room found",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: AppSizes.DEFAULT_PADDING * 3),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                              AppRoute.fadeInAnimation(
                                  const ManageRoomScreen())),
                          style: TextButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: AppColors.PRIMARY_COLOR),
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Manage room',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : SafeArea(
            child: DefaultTabController(
              animationDuration: const Duration(milliseconds: 500),
              length: roomLength,
              child: CustomScrollView(
                scrollBehavior: AppScroll(),
                slivers: [
                  SliverSafeArea(
                    top: false,
                    bottom: false,
                    sliver: SliverAppBar(
                      primary: false,
                      pinned: false,
                      floating: false,
                      backgroundColor: const Color(0xFFF7F7F7),
                      expandedHeight: 50,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.DEFAULT_PADDING,
                          ),
                          child: Row(
                            children: [
                              const PopupMenuWidget(),
                              const Spacer(),
                              const Icon(
                                Icons.notifications_none_outlined,
                                size: 25,
                                color: Color(0xFF2F2B2A),
                              ),
                              const SizedBox(width: AppSizes.DEFAULT_PADDING),
                              InkWell(
                                onTap: (() {
                                  Navigator.of(context).push(
                                      AppRoute.fadeInAnimation(
                                          ManageDeviceScreen(
                                    homeProvider: homeProvider,
                                  )));
                                }),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Color(0xFF2F2B2A),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    floating: true,
                    pinned: true,
                    delegate: CustomSliverPersistentWidget(
                      widget: const RoomTabWidget(),
                    ),
                  ),
                  const SliverFillRemaining(
                    child: TabBarViewWidget(),
                  ),
                ],
              ),
            ),
          );
  }
}
