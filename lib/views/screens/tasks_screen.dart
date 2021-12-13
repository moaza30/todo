import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
    selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          //Change selected Day
          onDaySelected: (sd, fd) {
            setState(() {
              selectedDay = sd;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          //Remove graued ot days
          weekendDays: [],
          headerStyle: HeaderStyle(titleCentered: true),
          locale: AppLocalizations.of(context)!.localeName,
          availableCalendarFormats: {CalendarFormat.week: 'week'},
          calendarFormat: CalendarFormat.week,
          focusedDay: selectedDay,
          firstDay: DateTime.now().subtract(Duration(days: 365)),
          lastDay: DateTime.now().add(Duration(days: 365)),
          calendarStyle: CalendarStyle(
            todayTextStyle: TextStyle(color: Colors.black),
            defaultTextStyle: TextStyle(color: Colors.black),
            selectedTextStyle: TextStyle(color: Colors.white),
            defaultDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            todayDecoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            itemCount: Provider.of<TasksProvider>(context).tasks.length,
            itemBuilder: (context, index) {
              return Taskitem(Provider.of<TasksProvider>(context).tasks[index]);
            },
          ),
        ),
      ],
    );
  }
}
