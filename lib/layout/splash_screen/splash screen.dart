
import 'package:TODO_app/shared/provider/auth%20provider.dart';
import 'package:TODO_app/style/app_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_Screen.dart';
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
    Future.delayed(Duration(seconds: 1),
          () {
            CheckAutoLogin();
      },);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color:Color(0xff5D9CEC),

            ),
            child: AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText('do IT!\ndo it RIGHT!!\ndo it RIGHT NOW!!!'),

              ],

            ),
          ),
        ),
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
