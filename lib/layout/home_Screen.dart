import 'package:chat_app/shared/provider/auth%20provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String route = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    authProvider provider =Provider.of<authProvider>(context);
    return Container(
      decoration:
      BoxDecoration(
          image: DecorationImage(
              image:AssetImage("assets/images/SIGN IN – 1.jpg"),fit: BoxFit.cover )),
      child: Scaffold( backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading:
          IconButton(onPressed: () async {
            await provider.SignOut();
            Navigator.pushReplacementNamed(context,LoginScreen.route );
          }, icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 20,)),
        ),

        body: Container(),
      ),
    );
  }
}
