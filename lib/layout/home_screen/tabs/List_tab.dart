import 'package:chat_app/layout/home_screen/widegets/task_widget.dart';
import 'package:chat_app/shared/provider/auth%20provider.dart';
import 'package:chat_app/shared/remote/firebase/firestore_helper.dart';
import 'package:chat_app/style/app_colors.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';

class ListTab extends StatefulWidget {
  ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    authProvider provider = Provider.of<authProvider>(context);

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now(),
          focusDate: selectedDate,
          lastDate: DateTime.now().add(Duration(days: 356)),
          timeLineProps: EasyTimeLineProps(),
          dayProps: EasyDayProps(
              borderColor: AppColors.ThirdLightColor,
              inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ))),
          activeColor: AppColors.ThirdLightColor,
          showTimelineHeader: false,
          onDateChange: (newSelectedDate) {
            setState(() {
              selectedDate = DateTime(
                  newSelectedDate.year,
                  newSelectedDate.month,
                  newSelectedDate.day,
              );
              print(selectedDate.toString());
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: StreamBuilder(
              stream: FirestoreHelper.ListenToTAsk(
                  provider.firebaseUserAuth!.uid, selectedDate.microsecondsSinceEpoch),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                          color: Colors.white, size: 50));
                  //Loading
                }
                if (snapshot.hasError) {
                  return Column(
                    children: [Text("Error${snapshot.error}")],
                  );
                  //Error
                }
                List<Task> tasks = snapshot.data ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) => taskWidget(
                    task: tasks[index],
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemCount: tasks.length,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
