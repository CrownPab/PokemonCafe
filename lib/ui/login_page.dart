import 'package:flutter/material.dart';
import 'package:pokemon_cafe/auth.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

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

  void validateAndSubmit(BuildContext context, ViewModel model) async {
    if (validateAndSave()) {
      try {
        if (_formMode == FormMode.SIGNIN) {
          String userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth.signUp(_email, _password);
          model.createAccount(userId, _email);
          print('Signed up user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    'Please ensure your email and password are correct.',
                  ),
                  actions: <Widget>[
                    TextButton(
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
      'Pokemon Cafe',
      textAlign: TextAlign.start,
      textScaleFactor: 2.0,
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                color: Colors.orange)),
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

  Widget _submitButton(BuildContext context, ViewModel model) {
    if (_formMode == FormMode.SIGNIN) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.red[700],
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.red[700],
                child: const Text('Login',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () => validateAndSubmit(context, model),
              )));
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Material(
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.red[700],
                child: const Text('Create account',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () => validateAndSubmit(context, model),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => Scaffold(
              body: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _logo(),
                    _emailInput(),
                    _passwordInput(),
                    _label(),
                    _submitButton(context, model)
                  ],
                ),
              ),
            ));
  }
}
