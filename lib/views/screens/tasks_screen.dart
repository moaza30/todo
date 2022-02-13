import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/controlles/tasks_provider.dart';
import 'package:todo_app/views/widgets/task_item.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late DateTime selectedDay;
  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          onDaySelected: (sd, fd) {
            setState(() {
              selectedDay = sd;
            });
          },
          weekendDays: [],
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          locale: AppLocalizations.of(context)!.localeName,
          availableCalendarFormats: {CalendarFormat.week: 'week'},
          headerStyle: HeaderStyle(titleCentered: true),
          calendarFormat: CalendarFormat.week,
          focusedDay: selectedDay,
          firstDay: DateTime.now().subtract(Duration(days: 365)),
          lastDay: DateTime.now().add(Duration(days: 365)),
          calendarStyle: CalendarStyle(
            todayTextStyle: TextStyle(color: Colors.black),
            defaultTextStyle: TextStyle(color: Colors.black),
            defaultDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            todayDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<String?>(
              future: Provider.of<TasksProvider>(context, listen: false)
                  .getTasks(selectedDay),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (snapshot.data == null) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    itemCount: Provider.of<TasksProvider>(context).tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                          Provider.of<TasksProvider>(context).tasks[index]);
                    },
                  );
                } else {
                  return Center(
                    child: Text(snapshot.data!),
                  );
                }
              }),
        )
      ],
    );
  }
}
//modalBottomSheet
