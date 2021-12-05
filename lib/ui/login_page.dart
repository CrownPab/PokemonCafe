import 'package:flutter/material.dart';
import 'package:pokemon_cafe/auth.dart';

class LoginPage extends StatefulWidget {
  final AuthImpl auth;
  final VoidCallback onSignedIn;
  LoginPage({required this.auth, required this.onSignedIn});
  @override
  _LoginPage createState() => new _LoginPage();
}

enum FormMode { SIGNIN, SIGNUP }

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  FormMode _formMode = FormMode.SIGNIN;
  String _email = "", _password = "";
  void _signUp() {
    formKey.currentState?.reset();
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _signIn() {
    formKey.currentState?.reset();
    setState(() {
      _formMode = FormMode.SIGNIN;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {
    if (validateAndSave()) {
      try {
        if (_formMode == FormMode.SIGNIN) {
          String userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth.signUp(_email, _password);
          print('Signed up user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    'Please ensure your email and password are correct.',
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    }
  }

  Widget _logo() {
    return Text(
      'Progress Bar',
      textAlign: TextAlign.start,
      textScaleFactor: 2.0,
      style: new TextStyle(color: Colors.grey),
    );
  }

  Widget _emailInput() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: const InputDecoration(
              hintText: 'Email',
              icon: Icon(
                Icons.mail,
                color: Colors.grey,
              )),
          validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value!,
        ));
  }

  Widget _passwordInput() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          obscureText: true,
          autofocus: false,
          decoration: const InputDecoration(
              hintText: 'Password',
              icon: Icon(
                Icons.lock,
                color: Colors.grey,
              )),
          validator: (value) =>
              value!.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value!,
        ));
  }

  Widget _label() {
    if (_formMode == FormMode.SIGNIN) {
      return TextButton(
        child: const Text('Create an account',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _signUp,
      );
    } else {
      return TextButton(
        child: const Text('Have an account? Sign in',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _signIn,
      );
    }
  }

  Widget _submitButton(BuildContext context) {
    if (_formMode == FormMode.SIGNIN) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.blueAccent.shade100,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.blue,
                child: const Text('Login',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () => validateAndSubmit(context),
              )));
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.lightBlueAccent.shade100,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.blue,
                child: const Text('Create account',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () => validateAndSubmit(context),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _logo(),
            _emailInput(),
            _passwordInput(),
            _label(),
            _submitButton(context)
          ],
        ),
      ),
    );
  }
}
