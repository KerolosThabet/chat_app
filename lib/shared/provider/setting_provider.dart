import 'package:TODO_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  SharedPreferences?  sharedPreferences;
  ThemeMode theme = ThemeMode.light;
  String language =  'ar' ;

  void changeLanguage(String newLanguage) {
    if(language == newLanguage)return;
    language = newLanguage;
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
   if( theme == newTheme)return;
   theme = newTheme;
    notifyListeners();
  }



}