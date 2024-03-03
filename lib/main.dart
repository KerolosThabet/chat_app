import 'package:chat_app/layout/home_Screen.dart';
import 'package:chat_app/style/theme.dart';
import 'package:flutter/material.dart';

import 'layout/login/login_screen.dart';
import 'layout/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: AppTheme.LightTheme ,
      darkTheme: AppTheme.DarkTheme,
      routes: {
        LoginScreen.route : (_)=>LoginScreen(),
        RegisterScreen.route : (_)=>RegisterScreen(),
        HomeScreen.route : (_)=> HomeScreen()
      },
      initialRoute: LoginScreen.route,

    );
  }
}
