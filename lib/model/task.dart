
import 'package:cloud_firestore/cloud_firestore.dart';

class Task{

  String? title;
  String? description;
  int? date ;
  String? id ;
  bool? isDone ;
  Task({required this.title, required this.description, required this.date, this.id,this.isDone=false});

  Task.fromFirestore(Map<String,dynamic>data){
    title=data['title'];
    description= data['description'];
    date =data["date"];
    id =data["id"];
    isDone =data["isDone"];
  }

  Map<String,dynamic> toFirestore(){
    Map<String,dynamic> data ={
      'title' :title!,
      'description' :description!,
      'date' :date!,
      'id' :id!,
      'isDone' :isDone,
    };
    return data;
  }

}