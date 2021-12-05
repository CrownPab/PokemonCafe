import 'package:flutter/material.dart';

class LevelText extends StatelessWidget {
  final int level;
  final double fontSize;
  LevelText({required this.level, this.fontSize = 26});

  @override
  Widget build(BuildContext context) {
    return Text('Lv.' + level.toString(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: fontSize,
        ));
  }
}
