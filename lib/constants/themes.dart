import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class AppThemes {
  static final TextStyle darkText = TextStyle(
    color: AppColors.whiteGrey,
    fontFamily: AppFonts.productSans,
  );

  static final TextStyle lightText = TextStyle(
    color: AppColors.black,
    fontFamily: AppFonts.productSans,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.lightBackgroundColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    textTheme: TextTheme(
      bodyLarge: lightText,
      bodyMedium: lightText,
      labelMedium: lightText,
      bodySmall: lightText,
      labelLarge: lightText,
      labelSmall: lightText,
    ),
    iconTheme: const IconThemeData(color: AppColors.darkGrey),
    // colorScheme:
    //     ColorScheme.fromSwatch().copyWith(background: AppColors.whiteGrey),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.darkBackgroundColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    textTheme: TextTheme(
      bodyLarge: darkText,
      bodyMedium: darkText,
      labelMedium: darkText,
      bodySmall: darkText,
      labelLarge: darkText,
      labelSmall: darkText,
    ),
    iconTheme: const IconThemeData(color: AppColors.lightGrey),
  );
}
