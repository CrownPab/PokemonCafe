import 'package:flutter/material.dart';

class XPText extends StatelessWidget {
  final int xp;
  final double fontSize;
  XPText({required this.xp, this.fontSize = 26});

  @override
  Widget build(BuildContext context) {
    return Text(xp.toString() + 'XP',
        style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: fontSize,
            decoration: TextDecoration.underline));
  }
}
