import 'package:do_an_1_iot/utils/local_data_source.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _localDataSource = LocalDataSource();
  }

  late LocalDataSource _localDataSource;
  bool _isDarkModeOn = false;

  bool get isDarkModeOn {
    _isDarkModeOn = _localDataSource.isDarkMode;
    return _isDarkModeOn;
  }

  void toggleTheme() {
    _localDataSource.toggleTheme();
    _isDarkModeOn = isDarkModeOn;

    notifyListeners();
  }
}
