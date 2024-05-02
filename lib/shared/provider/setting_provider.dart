import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode theme = ThemeMode.light;

  Future<void> changeTheme(ThemeMode newTheme) async {
   if( theme == newTheme)return;
   theme = newTheme;
    notifyListeners();
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setBool("isDark", newTheme == ThemeMode.dark);
  }

  Future<void> GetTheme () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool("isDark");
    if(isDark != null ){
      if(isDark){
       theme = ThemeMode.dark ;
      }else{
       theme = ThemeMode.light ;
      }
    notifyListeners();
    }

  }
}