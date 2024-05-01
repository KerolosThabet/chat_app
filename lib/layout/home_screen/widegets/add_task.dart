import 'package:TODO_app/style/app_colors.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/reusable_componenets/custom_form_field.dart';
import '../provider/home_provider.dart';


class AddTask extends StatefulWidget {
  void Function() isCanceled;
  TextEditingController TitleController ;
  TextEditingController descriptionController ;
  GlobalKey<FormState> formKey ;
  AddTask( {required this.isCanceled,required this.TitleController,required this.descriptionController,required this.formKey});

  @override
  State<AddTask> createState() => _AddTaskState();
}
class _AddTaskState extends State<AddTask> {

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return
      Container(
      color:Theme.of(context).colorScheme.onSecondary,
      padding: EdgeInsets.all(15),
      child: Form(
        key:widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add Task",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 15),
            CustomFormField(
                label: "Enter your task",
                controller: widget.TitleController,
                keyboard: TextInputType.text),
            SizedBox(height: 15,),
            CustomFormField(
                label: "Description your task",
                controller: widget.descriptionController,
                keyboard: TextInputType.multiline),
            SizedBox(height: 15,),
            InkWell(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)
                  ),
                  initialDate: DateTime.now(),
                );
                provider.selectNewDate(selectedDate);
                setState(() {
                  print(selectedDate);
                });
              },

              child: Text(
                provider.selectedDate==null ?"Select Date" :"${ provider.selectedDate?.day}-${ provider.selectedDate?.month}-${ provider.selectedDate?.year}",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.primaryLightColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                onPressed: () {
                  widget.isCanceled();
                  Navigator.pop(context);
                },
                child: Text("Cancel",style:Theme.of(context).textTheme.labelLarge?.
                copyWith( fontSize: 20),)),
            SizedBox(height: 25,),

          ],
        ),
      ),
    );
  }
}
