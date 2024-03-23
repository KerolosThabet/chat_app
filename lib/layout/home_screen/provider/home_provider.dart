import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  int currentIndex = 0 ;

   void changeIndex(int newIndex ){
     if(currentIndex == newIndex)return;
         currentIndex= newIndex ;
         notifyListeners();
   }
  DateTime? selectedDate;

  void selectNewDate(DateTime? newSelected){
    selectedDate = newSelected;
    notifyListeners();
  }
}