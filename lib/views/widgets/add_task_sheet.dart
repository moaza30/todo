import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controlles/tasks_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/widgets/sheet_label.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController titleController = TextEditingController();
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool isAdding = false;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30).add(
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SheetLabel(AppLocalizations.of(context)!.add_task_title),
            TextField(
              enabled: !isAdding,
              controller: titleController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
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
                  onPressed: isAdding
                      ? null
                      : () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 365)),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (pickedDate != null) {
                            selectedDate = pickedDate;
                            setState(() {});
                          }
                        },
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(selectedDate),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: isAdding
                      ? null
                      : () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (pickedTime != null) {
                            selectedTime = pickedTime;
                            setState(() {});
                          }
                        },
                  child: Text(
                    DateFormat('hh:mm a').format(combineDateAndTime()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: isAdding
                      ? null
                      : () {
                          // Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                  child: Text(
                    AppLocalizations.of(context)!.cancel_btn,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(width: 10),
                isAdding
                    ? CircularProgressIndicator.adaptive()
                    : ElevatedButton(
                        onPressed: () async {
                          if (titleController.text.isEmpty) {
                            print('hello');
                            showError('Missing Data',
                                'Please provide a title to the task');
                          } else {
                            String newId = Provider.of<TasksProvider>(context,
                                    listen: false)
                                .getNewId;
                            Task newTask = Task(newId, titleController.text,
                                combineDateAndTime());

                            setState(() {
                              isAdding = true;
                            });
                            String? error = await Provider.of<TasksProvider>(
                                    context,
                                    listen: false)
                                .addTask(newTask);

                            if (error == null) {
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                isAdding = false;
                              });
                              showError('Adding Task Failed', error);
                            }
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
