import 'package:flutter/material.dart';

class ScrollableBottomSheetHandler extends StatelessWidget {
  const ScrollableBottomSheetHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: FractionallySizedBox(
        widthFactor: 0.1,
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          height: 4,
          decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.black12),
        ),
      ),
    );
  }
}
