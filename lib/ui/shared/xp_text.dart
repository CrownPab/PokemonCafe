import 'package:flutter/material.dart';

class XPText extends StatelessWidget {
  final int xp;
  XPText(this.xp);

  @override
  Widget build(BuildContext context) {
    return Text(xp.toString() + 'XP',
        style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 26,
            decoration: TextDecoration.underline));
  }
}
