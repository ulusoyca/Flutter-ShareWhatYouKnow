import 'package:flutter/material.dart';

import '../../login_screen_03.dart';

class LoginPage extends Page {
  final VoidCallback onLogin;

  LoginPage({required this.onLogin}) : super(key: ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return LoginScreen(onLogin: onLogin);
      },
    );
  }
}
