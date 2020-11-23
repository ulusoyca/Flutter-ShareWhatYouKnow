import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-02-mobile-only-with-auth/login_screen_02.dart';

class LoginPage extends Page {
  final VoidCallback onLogin;

  LoginPage({@required this.onLogin}) : super(key: ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => LoginScreen(onLogin: onLogin),
    );
  }
}
