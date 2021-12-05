import 'package:flutter/material.dart';
import 'package:pokemon_cafe/account.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget {
  Account account;
  SignUpPage({Key? key, required this.account}) : super(key: key);
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  Widget _title() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: const Text(
        'Tell us about yourself',
        style: TextStyle(
            color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _componentWrapper(String text, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            )),
        const SizedBox(
          height: 10,
        ),
        child,
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }

  Widget nameInput() {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text('First Name')),
              onChanged: (value) => widget.account.firstName = value,
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Last Name')),
              onChanged: (value) => widget.account.lastName = value,
            ),
          ],
        ));
  }

  Widget usernameInput() {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text('Username')),
              onChanged: (value) => widget.account.userName = value,
            ),
          ],
        ));
  }

  Widget datePicker(BuildContext context) {
    return Container(
      child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.account.birthday,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        IconButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1950),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now());
              if (date != null) {
                setState(() {
                  widget.account.birthday =
                      "${date.day}-${date.month}-${date.year}";
                });
              }
            },
            icon: const Icon(Icons.calendar_today))
      ])),
    );
  }

  Widget _submit(BuildContext context, ViewModel model) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.orange[200],
            child: MaterialButton(
              minWidth: 200.0,
              hoverColor: Colors.white,
              height: 42.0,
              color: Colors.orange[200],
              child: const Text('Complete Sign Up',
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () {
                model.createAccount(widget.account);
                Navigator.of(context).pop();
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => Scaffold(
            backgroundColor: Colors.red[900],
            body: Theme(
              data: ThemeData.dark(),
              child: ListView(
                children: [
                  _title(),
                  _componentWrapper(
                      'What\'ll be your Username', usernameInput()),
                  _componentWrapper('What\'s your name?', nameInput()),
                  _componentWrapper(
                      'When\'s your birthday?', datePicker(context)),
                  _submit(context, model)
                ],
              ),
            )));
  }
}
