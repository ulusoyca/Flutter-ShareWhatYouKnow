import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/circular_button.dart';

class BottomSheetCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BottomSheetCloseButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      iconData: Icons.close,
      onPressed: () {
        var onButtonPress = this.onPressed;
        onButtonPress == null ? Navigator.of(context).maybePop() : onButtonPress();
      },
    );
  }
}
