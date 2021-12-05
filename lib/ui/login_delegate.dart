import 'package:flutter/material.dart';
import 'package:pokemon_cafe/auth.dart';
<<<<<<< HEAD
import 'package:pokemon_cafe/ui/home_page.dart';
import 'package:pokemon_cafe/ui/login_page.dart';
import 'package:pokemon_cafe/view_model.dart';
import 'package:scoped_model/scoped_model.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_SIGNED_IN,
  SIGNED_IN,
}

class LoginDelegate extends StatefulWidget {
=======

class LoginDelegate extends StatefulWidget {
  final Auth auth;
  LoginDelegate({Key? key, required this.auth}) : super(key: key);

>>>>>>> ab3bd46cf862de1a24f1a7487ec60079b8c0a2be
  _LoginDelegate createState() => _LoginDelegate();
}

class _LoginDelegate extends State<LoginDelegate> {
<<<<<<< HEAD
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.SIGNED_IN;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_SIGNED_IN;
    });
  }

  Widget _loading(Auth auth) {
    auth.getCurrentUser().then((userId) {
      setState(() {
        authStatus =
            userId == '----' ? AuthStatus.NOT_SIGNED_IN : AuthStatus.SIGNED_IN;
      });
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget CheckAuth(ViewModel model) {
    if (model.auth != null) {
      switch (authStatus) {
        case AuthStatus.NOT_DETERMINED:
          return _loading(model.auth!);
        case AuthStatus.NOT_SIGNED_IN:
          return LoginPage(
            auth: model.auth!,
            onSignedIn: _signedIn,
          );
        case AuthStatus.SIGNED_IN:
          model.onSignOut = _signedOut;
          return HomePage();
      }
    }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        builder: (context, child, model) => CheckAuth(model));
=======
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
>>>>>>> ab3bd46cf862de1a24f1a7487ec60079b8c0a2be
  }
}
