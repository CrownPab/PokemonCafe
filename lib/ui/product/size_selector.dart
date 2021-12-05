import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final int selection;
  final Function(int) callback;
  SizeSelector({Key? key, required this.selection, required this.callback})
      : super(key: key);

  Widget _option(int index, String value) {
    return GestureDetector(
        onTap: () => callback(index),
        child: Container(
            height: 50,
            width: 50,
            child: Center(
                child: Text(
              value,
              style: TextStyle(
                  color: selection == index ? Colors.white : Colors.red),
            )),
            decoration: BoxDecoration(
              color: selection == index ? Colors.red : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                  color: selection == index ? Colors.white : Colors.red),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _option(0, 'S'),
        Container(
          width: 80,
          height: 10,
          color: Colors.red[200],
        ),
        _option(1, 'M'),
        Container(
          width: 80,
          height: 10,
          color: Colors.red[200],
        ),
        _option(2, 'L')
      ],
    );
  }
}
