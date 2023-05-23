import 'dart:async';

import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/ui/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../statistic/statistic_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription<DatabaseEvent> _userStreamSubcription;

  int _selectedIndex = 0;
  bool _isInit = true;
  bool _isLoading = false;

  final List<Widget> _screen = <Widget>[
    const HomeScreen(),
    const ProfileScreen()
  ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    print('===================  DID CHANGE DEPENDENCIES');

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      /// Do something
      ///
      ///   - Fetch data
      ///   - Start stream
      ///   - ...
      ///
      ///
      final dataProvider = Provider.of<DataProvider>(context, listen: false);

      await dataProvider.startDataStreamSubcription();
      _userStreamSubcription = dataProvider.dataStreamSubcription;

      await dataProvider.waitUntilDataComing();

      ///!  Fix userData coming too late.

      setState(() {
        _isLoading = false;

        _isInit = false;
      });
    }
  }

  @override
  void dispose() async {
    print('===================  DIPOSE');

    _userStreamSubcription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const LoadingWidget()
        : Scaffold(
            body: _screen[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                // BottomNavigationBarItem(
                //     icon: Icon(Icons.data_thresholding_outlined),
                //     label: 'Statistic'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_outlined),
                    label: 'Profile'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.primaryColor,
              onTap: _onItemTapped,
            ),
          );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
