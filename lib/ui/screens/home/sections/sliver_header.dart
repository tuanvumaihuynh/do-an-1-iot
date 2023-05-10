import 'package:do_an_1_iot/constants/sizes.dart';
import 'package:do_an_1_iot/routes.dart';
import 'package:do_an_1_iot/ui/screens/home/widgets/pop_up_menu_widget.dart';
import 'package:flutter/material.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({super.key, this.tabController});

  final TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      expandedHeight: 50,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
        child: Row(
          children: [
            PopUpMenuWidget(tabController: tabController),
            const Spacer(),
            const Icon(
              Icons.notifications_none_outlined,
              size: 25,
            ),
            const SizedBox(width: AppSizes.defaultPadding),
            InkWell(
              onTap: () async {
                AppNavigator.push(Routes.manageRoom);
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            )
          ],
        ),
      );
}
