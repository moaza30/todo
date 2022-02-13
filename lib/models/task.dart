import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Task {
  String _id;
  String title;
  bool done;
  DateTime dateTime;
  String _dateString;
  Task(this._id, this.title, this.dateTime, {this.done = false})
      : _dateString = DateFormat('dd/MM/yyyy').format(dateTime);

  String get id => _id;

  Task.fromJson(Map<String, Object?> json)
      : this(
          json['id']! as String,
          json['title']! as String,
          (json['dateTime']! as Timestamp).toDate(),
          done: json['done']! as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'id': _id,
      'dateString': _dateString,
      'title': title,
      'dateTime': dateTime,
      'done': done,
    };
  }
}
