import 'package:flutter/material.dart';

class SheetLabel extends StatelessWidget {
  String label;

  SheetLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
