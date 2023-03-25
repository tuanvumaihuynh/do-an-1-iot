import 'package:do_an_1_iot/constants/app_sizes.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/custom_sliver_persistent_widget.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/home_body_widget.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/popup_menu_widget.dart';
import 'package:do_an_1_iot/ui/views/home/widgets/room_listview_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            backgroundColor: const Color(0xFFF7F7F7),
            expandedHeight: 50,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.DEFAULT_PADDING),
                child: Row(
                  children: const [
                    PopupMenuWidget(),
                    Spacer(),
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 25,
                      color: Color(0xFF2F2B2A),
                    ),
                    SizedBox(width: AppSizes.DEFAULT_PADDING),
                    Icon(
                      Icons.add,
                      size: 30,
                      color: Color(0xFF2F2B2A),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: CustomSliverPersistentWidget(
              widget: const RoomListviewWidget(),
            ),
          ),
          const SliverFillRemaining(child: HomeBodyWidget()),
        ],
      ),
    );
  }
}
