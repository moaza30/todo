import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> tasks;

  TasksProvider() : this.tasks = [];

  void addTaks(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  }
}
