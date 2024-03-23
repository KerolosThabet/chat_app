import 'package:chat_app/shared/provider/auth%20provider.dart';
import 'package:chat_app/shared/remote/firebase/firestore_helper.dart';
import 'package:chat_app/shared/reusable_componenets/custom_form_field.dart';
import 'package:chat_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';

class EditTask extends StatefulWidget {
  static const String route = 'editScreen';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController TitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime selectedDate ;
  bool first = true;

  @override
  Widget build(BuildContext context) {
    authProvider provider = Provider.of<authProvider>(context);
    Task task = ModalRoute.of(context)?.settings.arguments as Task;
    if (first) {
      TitleController.text = task.title ?? '';
      descriptionController.text = task.description ?? '';
      selectedDate = DateTime.fromMicrosecondsSinceEpoch(task.date!);
      first = false;
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: AppColors.primaryLightColor,
          ),
          SafeArea(
            child: ListView(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Text(
                      "Edit Task ",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        "Edit",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      CustomFormField(
                          label: "Title",
                          controller: TitleController,
                          keyboard: TextInputType.text),
                      SizedBox(
                        height: 15,),
                      CustomFormField(
                          label: "Description ",
                          controller: descriptionController,
                          keyboard: TextInputType.multiline),
                      SizedBox(height: 15,),
                     InkWell(
                        onTap: () async {
                          DateTime? _selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialDate:selectedDate,
                          );
                          selectedDate =_selectedDate??selectedDate;
                          setState(() {
                            print(selectedDate);
                          });
                        },
                        child: Text(
                             '${DateFormat.yMd().format(selectedDate)}',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 200,),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColors.primaryLightColor),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          onPressed: () {
                            Task taskAfterEdit = Task(title: TitleController.text, description: descriptionController.text, date: selectedDate.microsecondsSinceEpoch,id: task.id,isDone: task.isDone);
                            FirestoreHelper.EditeTask(taskAfterEdit, provider.firebaseUserAuth!.uid);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Save Edit",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20),
                          )),
                      SizedBox(height: 25,),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
