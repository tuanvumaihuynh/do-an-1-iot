import 'package:hive_flutter/hive_flutter.dart';

class LocalDataSource {
  LocalDataSource() {
    themeBox = Hive.box(darkMode);
  }

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(darkMode);
  }

  late Box<dynamic> themeBox;

  static const String darkMode = "is_dark_mode";

  bool get isDarkMode {
    var isDarkModeOn = themeBox.get(darkMode);
    return isDarkModeOn ?? false;
  }

  void toggleTheme() {
    themeBox.put(darkMode, !isDarkMode);
  }
}
