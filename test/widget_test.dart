// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:do_an_1_iot/utils/local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('LocalDataSource', () {
    late LocalDataSource localDataSource;

    setUpAll(() async {
      await Hive.initFlutter();
    });

    setUp(() async {
      await Hive.deleteBoxFromDisk(LocalDataSource.darkMode);
      await LocalDataSource.initialize();
      localDataSource = LocalDataSource();
    });

    test('isDarkMode returns false by default', () {
      expect(localDataSource.isDarkMode, false);
    });

    test('toggleTheme toggles the dark mode', () {
      localDataSource.toggleTheme();
      expect(localDataSource.isDarkMode, true);

      localDataSource.toggleTheme();
      expect(localDataSource.isDarkMode, false);
    });

    test('isDarkMode returns true after toggling the theme', () {
      localDataSource.toggleTheme();
      expect(localDataSource.isDarkMode, true);
    });
  });
}
