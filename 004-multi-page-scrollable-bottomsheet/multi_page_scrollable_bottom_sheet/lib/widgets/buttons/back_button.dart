import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/circular_button.dart';

class BottomSheetBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BottomSheetBackButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      iconData: Icons.arrow_back,
      onPressed: () {
        var onButtonPress = this.onPressed;
        onButtonPress == null ? Navigator.of(context).maybePop() : onButtonPress();
      },
    );
  }
}
