import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:do_an_1_iot/ui/views/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:do_an_1_iot/constants/app_colors.dart';
import 'package:do_an_1_iot/ui/views/home/home_screen.dart';
import 'package:do_an_1_iot/ui/views/profile/profile_screen.dart';
import 'package:do_an_1_iot/ui/views/statistic/statistic_screen.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  var _isInit = true;
  var _isLoading = false;

  final List<Widget> _screen = <Widget>[
    const HomeScreen(),
    const StatisticScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    print('DIDCHANGEDEPENDENCIES');
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await context.read<UserProvider>().fetchAndSetUserData();
      // final homeIDList = context.read<UserProvider>().homeIDList;
      // final homeIDList =
      //     Provider.of<UserProvider>(context, listen: false).homeIDList;

      await Provider.of<HomeProvider>(context, listen: false).fetchHomeData();
      // Stream for user listener
      context.read<UserProvider>().listenToUserModel();

      setState(() {
        _isLoading = false;
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print('DISPOSE');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: _screen.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: const Color(0xFF333333),
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 100),
            tabBackgroundColor: AppColors.PRIMARY_COLOR,
            color: const Color(0xFF666666),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.data_thresholding_outlined,
                text: 'Statistic',
              ),
              GButton(
                icon: Icons.person_outline_outlined,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
