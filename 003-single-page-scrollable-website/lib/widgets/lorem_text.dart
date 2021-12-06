import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class LoremText extends StatefulWidget {
  const LoremText({Key? key, required this.seed}) : super(key: key);

  final int seed;

  @override
  _LoremTextState createState() => _LoremTextState();
}

class _LoremTextState extends State<LoremText> {
  final int minNumberOfParagraphs = 2;
  final int maxNumberOfParagraphs = 6;
  late int numOfParagraphs;

  @override
  void initState() {
    super.initState();
    final randomNumberOfParagraphs = Random(widget.seed).nextInt(maxNumberOfParagraphs);
    numOfParagraphs = max(randomNumberOfParagraphs, minNumberOfParagraphs);
  }

  @override
  Widget build(BuildContext context) {
    final paragraphs = lorem(paragraphs: numOfParagraphs, words: numOfParagraphs * 150);
    return SelectableText(paragraphs);
  }
}
