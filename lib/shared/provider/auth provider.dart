import 'package:TODO_app/shared/remote/firebase/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:TODO_app/model/user.dart' as MyUser ;
import 'package:firebase_auth/firebase_auth.dart';


class authProvider extends ChangeNotifier {
  User? firebaseUserAuth ;
 MyUser.User? databaseUser ;

 void setUsers (User? newFirebaseUserAuth ,MyUser.User? newDatabaseUser ){
   firebaseUserAuth = newFirebaseUserAuth ;
     databaseUser = newDatabaseUser ;
 }
 bool isFirebaseUserLoggedin(){
   if(FirebaseAuth.instance.currentUser== null ) return false ;
   firebaseUserAuth= FirebaseAuth.instance.currentUser ;
   return true ;
 }

 retrieveDatabaseUserData() async {
   try{
     databaseUser =await FirestoreHelper.GetUser(firebaseUserAuth!.uid);
   }catch(Error){
     print(Error);
   }
 }

 Future<void> SignOut() async {
   firebaseUserAuth = null ;
   databaseUser = null ;
   return await FirebaseAuth.instance.signOut();
 }
}