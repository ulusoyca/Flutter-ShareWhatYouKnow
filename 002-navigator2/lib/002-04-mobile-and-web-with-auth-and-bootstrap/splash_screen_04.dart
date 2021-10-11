import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String? process;

  const SplashScreen({Key? key, this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
            'Splash !!!!!\n\n$process',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          )),
    );
  }
}
