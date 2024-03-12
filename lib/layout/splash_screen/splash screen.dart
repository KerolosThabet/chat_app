
import 'package:chat_app/shared/provider/auth%20provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_Screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),
          () {
            CheckAutoLogin();
      },);
    return Container(
      decoration: BoxDecoration(image:
      DecorationImage(image:  AssetImage("assets/images/splash.png"),
          fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Future<void> CheckAutoLogin() async {
    authProvider provider = Provider.of<authProvider>(context,listen: false);
    if(provider.isFirebaseUserLoggedin()){
      await provider.retrieveDatabaseUserData();
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    }else{
      Navigator.pushReplacementNamed(context,LoginScreen.route);
    }
  }
}
