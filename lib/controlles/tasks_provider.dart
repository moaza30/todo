import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> tasks;
  String selectedDateString;
  TasksProvider()
      : this.tasks = [],
        selectedDateString = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final tasksRef =
      FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
            fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
            toFirestore: (Task, _) => Task.toJson(),
          );

  Future<String?> addTask(Task newTask) async {
    try {
      await tasksRef.doc(newTask.id).set(newTask);
      if (selectedDateString ==
          DateFormat('dd/MM/yyyy').format(newTask.dateTime)) {
        tasks.add(newTask);
        notifyListeners();
      }
      return null;
    } catch (error) {
      print(error);
      return 'Sorry, We could not add your task please try again later.';
    }
  }

  Future<String?> getTasks(DateTime selectedDate) async {
    try {
      tasks.clear();
      tasks = [];
      selectedDateString = DateFormat('dd/MM/yyyy').format(selectedDate);
      final querySS = await tasksRef
          .where('dateString',
              isEqualTo: DateFormat('dd/MM/yyyy').format(selectedDate))
          .get();
      querySS.docs.forEach((element) {
        tasks.add(element.data());
      });
      notifyListeners();
      return null;
    } catch (error) {
      print(error);
      return 'Sorry, We could not get your tasks please try again later.';
    }
  }

  Future<String?> deleteTask(Task task) async {
    try {
      await tasksRef.doc(task.id).delete();
      tasks.remove(task);
      notifyListeners();
      return null;
    } catch (error) {
      print(error);
      return 'Sorry, We could not delete your task please try again later.';
    }
  }

  String get getNewId {
    return tasksRef.doc().id;
  }

  Future<String?> updateTaskStatus(Task task) async {
    try {
      task.done = !task.done;
      await tasksRef.doc(task.id).set(task);
      notifyListeners();
      return null;
    } catch (error) {
      task.done = !task.done;
      print(error);
      notifyListeners();
      return 'Sorry, We could not update the status of your task please try again later.';
    }
  }
}
