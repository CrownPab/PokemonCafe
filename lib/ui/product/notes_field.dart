import 'package:flutter/material.dart';

// there was a reason i made this stateful which I completely forget
// but im sure itll come back to me ... i hope
class NotesField extends StatefulWidget {
  final Function(String) callback;
  NotesField({Key? key, required this.callback}) : super(key: key);

  _NotesField createState() => _NotesField();
}

class _NotesField extends State<NotesField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: controller,
          onChanged: widget.callback,
          maxLines: null,
          decoration: const InputDecoration(
              hintText: 'Let us know of any alergies or special requests!'),
        ),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(8.0)));
  }
}
