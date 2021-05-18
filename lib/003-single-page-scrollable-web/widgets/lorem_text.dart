import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class LoremText extends StatefulWidget {
  const LoremText({Key key}) : super(key: key);

  @override
  _LoremTextState createState() => _LoremTextState();
}

class _LoremTextState extends State<LoremText> {
  final int minNumberOfParagraphs = 2;
  final int maxNumberOfParagraphs = 6;
  int numOfParagraphs;

  @override
  void initState() {
    numOfParagraphs = max(Random().nextInt(maxNumberOfParagraphs), minNumberOfParagraphs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paragraphs = lorem(paragraphs: numOfParagraphs, words: numOfParagraphs * 150);
    return SelectableText(paragraphs);
  }
}
