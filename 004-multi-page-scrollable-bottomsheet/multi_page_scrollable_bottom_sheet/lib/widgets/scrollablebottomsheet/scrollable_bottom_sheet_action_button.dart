import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';

class ScrollableBottomSheetActionButton extends StatelessWidget {
  final ValueListenable<String?>? actionTextListenable;
  final ValueListenable<bool?>? actionEnabledListenable;
  final ValueListenable<PrimaryButtonState>? actionButtonStateListenable;
  final ValueListenable<VoidCallback?>? actionListenable;
  final ValueListenable<AppColorNames>? actionButtonColor;
  final EdgeInsetsDirectional edgeInsetsDirectional;

  const ScrollableBottomSheetActionButton({
    Key? key,
    required this.edgeInsetsDirectional,
    required this.actionButtonColor,
    this.actionTextListenable,
    this.actionEnabledListenable,
    this.actionButtonStateListenable,
    this.actionListenable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsDirectional,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          actionEnabledListenable,
          actionButtonStateListenable,
          actionTextListenable,
        ]),
        builder: (BuildContext context, Widget? child) {
          return PrimaryButton(
            text: actionTextListenable?.value ?? '',
            onPressed: actionListenable?.value,
            disabled: actionEnabledListenable?.value == false,
            buttonState: actionButtonStateListenable,
            colorName: actionButtonColor?.value ?? AppColorNames.blue,
          );
        },
      ),
    );
  }
}
