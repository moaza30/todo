import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/widgets/sheet_label.dart';
import 'package:todo_app/controlles/tasks_provider.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  late TextEditingController titleController = TextEditingController();
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  // Remove from Mobile's ram use dispose
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  DateTime combineDateAndTime() {
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25)
            .add(EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
            SheetLabel(AppLocalizations.of(context)!.add_task_title),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.task_title_hint,
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  SheetLabel(AppLocalizations.of(context)!.select_time_label),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );

                    if (pickedDate != null) {
                      selectedDate = pickedDate;
                      setState(() {});
                    }
                  },
                  child: Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (pickedTime != null) {
                      selectedTime == pickedTime;
                      setState(() {});
                    }
                  },
                  child: Text(
                    DateFormat('hh:mm a').format(
                      combineDateAndTime(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel_btn,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Missing data"),
                            content: Text('Please provide a title to the task'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ok'))
                            ],
                          );
                        },
                      );
                    } else {
                      Task newTask =
                          Task(titleController.text, combineDateAndTime());
                      Provider.of<TasksProvider>(context, listen: false)
                          .addTaks(newTask);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add_btn,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
