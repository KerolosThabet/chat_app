
import 'package:chat_app/layout/home_screen/provider/home_provider.dart';
import 'package:chat_app/layout/home_screen/tabs/List_tab.dart';
import 'package:chat_app/layout/home_screen/tabs/settings_tab.dart';
import 'package:chat_app/layout/home_screen/widegets/add_task.dart';
import 'package:chat_app/model/task.dart';
import 'package:chat_app/shared/dialog_utils.dart';
import 'package:chat_app/shared/provider/auth%20provider.dart';
import 'package:chat_app/shared/remote/firebase/firestore_helper.dart';
import 'package:chat_app/style/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String route = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> Tabs = [ListTab(), SettingsTab()];
  TextEditingController TitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isBottomSheetOpened = false;

  @override
  Widget build(BuildContext context) {
    authProvider provider = Provider.of<authProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    bool isKeyBoardOpened = MediaQuery.of(context).viewInsets.bottom != 0;

    return
      Scaffold(
        floatingActionButton: isKeyBoardOpened ? null
            : SizedBox(
              height: 65,
              width: 65,
              child: FloatingActionButton(
                  onPressed: () {
                    if (!isBottomSheetOpened) {
                      AddNewTaskBottomSheet();
                      isBottomSheetOpened = true;
                    } else {
                      if((formKey.currentState?.validate()??false)&&homeProvider.selectedDate !=null){
                        FirestoreHelper.AddTask(
                            Task(title: TitleController.text,
                                description: descriptionController.text,
                                date: homeProvider.selectedDate!.microsecondsSinceEpoch,),
                            provider.firebaseUserAuth!.uid
                        );
                        Navigator.pop(context);

                        isBottomSheetOpened = false;
                      }
                    }
                    setState(() {});
                  },
                  child:isBottomSheetOpened
                      ?Icon(Icons.check, color: Colors.white, size: 25)
                      : Icon(Icons.add, color: Colors.white, size: 25),

                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.white, width: 5),
                  ),

                  backgroundColor: AppColors.primaryLightColor,
                  clipBehavior: Clip.antiAlias,

                ),
            ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.all(double.minPositive),
          shape: CircularNotchedRectangle(),
          notchMargin: 15,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            onTap: (Index) {
              homeProvider.changeIndex(Index);
            },
            elevation: 20,
            currentIndex: homeProvider.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        ),

        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                await provider.SignOut();
                Navigator.pushReplacementNamed(context, LoginScreen.route);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 20,
              )),
          centerTitle: true,
          title: Text(
            "Todo App",
            style: TextStyle(color: Colors.white,),
          ),
        ),

        body: Scaffold(
          key: scaffoldKey,
          body: Tabs[homeProvider.currentIndex],

        ),

    );
  }

  void AddNewTaskBottomSheet() {
    scaffoldKey.currentState?.showBottomSheet((context) =>
        AddTask(
            TitleController:TitleController ,
        descriptionController: descriptionController,
        formKey: formKey,
      isCanceled:() {
      isBottomSheetOpened = false;
      setState(() {});
    },));
  }
}
