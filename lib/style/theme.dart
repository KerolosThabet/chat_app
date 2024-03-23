import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppTheme {
  static  ThemeData LightTheme = ThemeData(
    appBarTheme: AppBarTheme(

        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
        backgroundColor: AppColors.primaryLightColor
    ),
    scaffoldBackgroundColor: AppColors.HomeColor ,

      floatingActionButtonTheme: FloatingActionButtonThemeData(iconSize: 50),
      bottomNavigationBarTheme:   BottomNavigationBarThemeData(
       selectedItemColor: AppColors.primaryLightColor,
         unselectedItemColor: AppColors.SecondaryLightColor,
        selectedIconTheme: IconThemeData(size: 40),
        unselectedIconTheme: IconThemeData(size: 30),
        elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false
      ),
      textTheme: TextTheme(

       labelLarge: TextStyle(
           color: Colors.black87,
         fontSize: 25 , fontWeight: FontWeight.w700,
       )  ,

        titleMedium: TextStyle(
          color: AppColors.primaryLightColor,
          fontSize: 25 , fontWeight: FontWeight.w700,
        )  ,

       titleLarge :TextStyle(
          color: Colors.white,
          fontSize: 25 ,
         fontWeight: FontWeight.bold
        ),

    titleSmall:TextStyle(
          color: Colors.black,
          fontSize: 15 ,
        ),
      ),


  ) ;
  static ThemeData DarkTheme = ThemeData();
}