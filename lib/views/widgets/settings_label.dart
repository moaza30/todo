import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsLabel extends StatelessWidget {
  final String label;

  SettingsLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
