import 'package:TODO_app/shared/provider/auth%20provider.dart';
import 'package:TODO_app/shared/remote/firebase/firestore_helper.dart';
import 'package:TODO_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';
import '../../edit_task_screen/edit_task.dart';

class taskWidget extends StatefulWidget {
  Task task;
 taskWidget({super.key, required this.task});

  @override
  State<taskWidget> createState() => _taskWidgetState();
}

class _taskWidgetState extends State<taskWidget> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    DateTime? taskDate = DateTime.fromMicrosecondsSinceEpoch(widget.task.date??0);
    authProvider provider = Provider.of<authProvider>(context);

    return Slidable(
      startActionPane: ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.27 ,
          children: [
            SlidableAction(
                onPressed: (context) {
                  FirestoreHelper.DeletTask(uid: provider.firebaseUserAuth!.uid,
                      taskId: widget.task.id??"");
                },
              icon: Icons.delete,
              label: "Delete",
              backgroundColor: Colors.redAccent,
              borderRadius:  BorderRadius.all(Radius.circular(15)),

            )
      ]
      ),
      endActionPane:ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.27 ,
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTask.route,arguments: widget.task);
              },
              icon: Icons.edit,
              label: "Edit",
              backgroundColor: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(15)),

            )
          ]
      ) ,

      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color:Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(20),),
      child: Row(
        children: [
          Container(
            height: height * 0.1,
             width: 5,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
               color:widget.task.isDone==true ? Colors.green: AppColors.primaryLightColor,
             ),
          ),
          SizedBox(width: 15,),
         Column(
           children: [
             Text(widget.task.title??'',
               style: Theme.of(context).textTheme.titleMedium?.copyWith( color:widget.task.isDone==true ? Colors.green: AppColors.primaryLightColor) ),
             Text(widget.task.description??'',
                 style: Theme.of(context).textTheme.titleSmall?.copyWith( color:widget.task.isDone==true ? Colors.green: AppColors.primaryLightColor) ),

             SizedBox(height: 10,),
             Row(
               children: [
                 Icon(Icons.access_time_outlined, color: Colors.black45,),
                 Text( "${DateFormat.jm().format(taskDate)} ",
                   style: Theme.of(context).textTheme.titleSmall, ),

               ],
             ),

           ],
         ),
          Spacer(),
          widget.task.isDone == true ?
          InkWell(
            onTap: () {
              widget.task.isDone = !(widget.task.isDone??false);
              FirestoreHelper.EditeTask(widget.task, provider.firebaseUserAuth!.uid);
            },
              child: Text("Done!",
                style: TextStyle(fontSize: 20, color: Colors.green,fontWeight: FontWeight.bold),)
          ) :
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.primaryLightColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
            onPressed: () {widget.task.isDone = !(widget.task.isDone??false);
            FirestoreHelper.EditeTask(widget.task, provider.firebaseUserAuth!.uid);},
            child: Icon(Icons.check,color: Colors.white,),
          ),
        ],
      ),
      ),

    );
  }
}
