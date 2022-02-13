import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controlles/tasks_provider.dart';
import 'package:todo_app/models/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDeleting = false, isUpdating = false;

  void showError(String title, String body) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void updateTaskStatus() async {
    setState(() {
      isUpdating = true;
    });
    String? error = await Provider.of<TasksProvider>(context, listen: false)
        .updateTaskStatus(widget.task);
    setState(() {
      isUpdating = false;
    });
    if (error != null) {
      showError('Status update failed', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: BehindMotion(),
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    isDeleting = true;
                  });
                  String? error =
                      await Provider.of<TasksProvider>(context, listen: false)
                          .deleteTask(widget.task);
                  if (error != null) {
                    showError('Deleting Task Failed', error);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  child: isDeleting
                      ? Center(
                          child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              AppLocalizations.of(context)!.delete_btn,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.secondary,
          ),
          padding: EdgeInsets.all(10),
          //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ListTile(
            horizontalTitleGap: 0,
            leading: VerticalDivider(
              thickness: 4,
              color: widget.task.done
                  ? Colors.green
                  : Theme.of(context).primaryColor,
            ),
            title: Text(
              widget.task.title,
              style: TextStyle(
                color: widget.task.done
                    ? Colors.green
                    : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: 14,
                  ),
                  Text(DateFormat('hh:mm a').format(widget.task.dateTime)),
                ],
              ),
            ),
            trailing: (isUpdating)
                ? CircularProgressIndicator.adaptive()
                : (widget.task.done)
                    ? TextButton(
                        onPressed: updateTaskStatus,
                        child: Text(
                          'Done!',
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            widget.task.done
                                ? Colors.green
                                : Theme.of(context).primaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: updateTaskStatus,
                        child: Icon(Icons.check),
                      ),
          ),
        ),
      ),
    );
  }
}
