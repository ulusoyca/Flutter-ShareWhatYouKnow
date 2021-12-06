import 'package:flutter/material.dart';

class ScrollableBottomSheetHandler extends StatelessWidget {
  const ScrollableBottomSheetHandler({Key? key}) : super(key: key);

  static final topMargin = 8.0;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: FractionallySizedBox(
        widthFactor: 0.1,
        child: Container(
          margin: EdgeInsets.only(top: topMargin),
          height: 4,
          decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.black12),
        ),
      ),
    );
  }
}
