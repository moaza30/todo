import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  startActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: BehindMotion(),
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.delete_btn,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    //ListTile
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: VerticalDivider(
                        thickness: 4,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        'Task Title',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 14,
                            ),
                            Text('10:00 PM')
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {},
                        child: Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
