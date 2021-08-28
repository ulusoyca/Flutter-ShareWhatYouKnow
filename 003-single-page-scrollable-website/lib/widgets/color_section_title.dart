import 'package:flutter/material.dart';

class ColorSectionTitle extends StatelessWidget {
  final String title;

  const ColorSectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(title, style: Theme.of(context).textTheme.headline4),
    );
  }
}
