import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';

class Taskitem extends StatelessWidget {
  final Task task;

  Taskitem(this.task);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        startActionPane:
            ActionPane(extentRatio: 0.25, motion: BehindMotion(), children: [
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
              color: task.done ? Colors.green : Theme.of(context).primaryColor,
            ),
            title: Text(
              task.title,
              style: TextStyle(
                  color:
                      task.done ? Colors.green : Theme.of(context).primaryColor,
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
                  Text(DateFormat('hh:mm:a').format(task.dateTime)),
                ],
              ),
            ),
            trailing: (task.done)
                ? Text('Done',
                    style: TextStyle(color: Colors.green, fontSize: 20))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: task.done
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: Icon(Icons.check),
                  ),
          ),
        ),
      ),
    );
  }
}
