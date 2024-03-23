import 'package:chat_app/layout/home_screen/home_Screen.dart';
import 'package:chat_app/layout/home_screen/provider/home_provider.dart';
import 'package:chat_app/shared/provider/auth%20provider.dart';
import 'package:chat_app/style/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout/edit_task_screen/edit_task.dart';
import 'layout/login/login_screen.dart';
import 'layout/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'layout/splash_screen/splash screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => authProvider(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        EditTask.route : (_)=>EditTask(),
        HomeScreen.route : (_)=> ChangeNotifierProvider(
          create: (_) => HomeProvider(),
            child: HomeScreen()),

        SplashScreen.route : (_)=> SplashScreen()
      },
      initialRoute:SplashScreen.route,

    );
  }
}
