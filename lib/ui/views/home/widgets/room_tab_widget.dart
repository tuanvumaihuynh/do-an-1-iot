import 'package:do_an_1_iot/constants/app_route.dart';
import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/ui/views/home/manage_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomTabWidget extends StatelessWidget {
  const RoomTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final roomList = homeProvider.selectedHome.room;

    List<Tab> buildTapRoom() => roomList!
        .map(
          (room) => Tab(
            child: Text(
              room.name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        )
        .toList();

    return Material(
      color: const Color(0xFFF7F7F7),
      child: Row(children: [
        Expanded(
          child: TabBar(
            labelPadding: const EdgeInsets.only(left: 0, right: 20),
            unselectedLabelColor: const Color(0xFF958B8A),
            labelColor: const Color(0xFF4A4444),
            indicatorColor: Colors.transparent,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            tabs: buildTapRoom(),
          ),
        ),
        const SizedBox(width: AppSizes.DEFAULT_PADDING),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(AppRoute.fadeInAnimation(const ManageRoomScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black12),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Icon(
                Icons.my_library_books_outlined,
                size: 25,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
