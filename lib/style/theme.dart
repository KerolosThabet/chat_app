import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData LightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: AppColors.primaryLightColor),
    scaffoldBackgroundColor: AppColors.HomeLightColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLightColor,
      background: AppColors.HomeLightColor,
      primary: AppColors.primaryLightColor ,
      secondary:  AppColors.SecondaryLightColor,
      tertiary:  AppColors.ThirdLightColor,
      onSecondary:  AppColors.TaskWidgetLightColor

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(iconSize: 50),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryLightColor,
        unselectedItemColor: AppColors.SecondaryLightColor,
        selectedIconTheme: IconThemeData(size: 40),
        unselectedIconTheme: IconThemeData(size: 30),
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        color: Colors.black87,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.primaryLightColor,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          color: AppColors.primaryLightColor,
          fontSize: 15,
          fontWeight: FontWeight.w400),
    ),
  );

  static ThemeData DarkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: AppColors.primaryDarkColor),
    scaffoldBackgroundColor: AppColors.HomeDarkColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.HomeDarkColor,
      background: AppColors.HomeDarkColor,
      primary: AppColors.primaryDarkColor ,
      secondary:  AppColors.SecondaryDarkColor,
      tertiary:  AppColors.ThirdDarkColor,
        onSecondary:  AppColors.ThirdDarkColor

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(iconSize: 50),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryDarkColor,
        unselectedItemColor: AppColors.SecondaryDarkColor,
        selectedIconTheme: IconThemeData(size: 40),
        unselectedIconTheme: IconThemeData(size: 30),
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.primaryDarkColor,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          color: AppColors.primaryDarkColor,
          fontSize: 15,
          fontWeight: FontWeight.w400),
    ),
  );
}
