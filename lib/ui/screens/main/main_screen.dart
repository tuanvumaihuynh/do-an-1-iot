import 'dart:async';

import 'package:do_an_1_iot/constants/colors.dart';
import 'package:do_an_1_iot/models/weather_model.dart';
import 'package:do_an_1_iot/providers/data_provider.dart';
import 'package:do_an_1_iot/providers/weather_provider.dart';
import 'package:do_an_1_iot/ui/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

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

  WeatherModel? weatherModel;

  final List<Widget> _screen = <Widget>[
    const HomeScreen(),
    const ProfileScreen()
  ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final dataProvider = Provider.of<DataProvider>(context, listen: false);

      await Future.wait([
        dataProvider.startDataStreamSubcription(),
        dataProvider.waitUntilDataComing(),
        // Provider.of<WeatherProvider>(context, listen: false).getWeatherData(),
      ]);

      _userStreamSubcription = dataProvider.dataStreamSubcription;

      setState(() {
        _isLoading = false;

        _isInit = false;
      });
    }
  }

  @override
  void dispose() async {
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
