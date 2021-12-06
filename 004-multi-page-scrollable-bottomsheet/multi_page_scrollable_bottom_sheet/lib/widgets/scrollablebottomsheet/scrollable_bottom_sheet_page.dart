import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';

class ScrollableBottomSheetPage {
  final Widget title;
  final String appbarTitle;
  final Widget content;
  final Widget? header;
  final double? headerHeight;
  final VoidCallback? onBackPressed;
  final VoidCallback? onClosePressed;
  final Color backgroundColor;
  final ValueListenable<String?>? actionTextListenable;
  final ValueListenable<bool?>? actionEnabledListenable;
  final ValueListenable<PrimaryButtonState>? actionButtonStateListenable;
  final ValueListenable<VoidCallback?>? actionListenable;
  final ValueListenable<AppColorNames>? actionButtonColor;

  ScrollableBottomSheetPage({
    required this.title,
    required this.content,
    required this.appbarTitle,
    this.actionTextListenable,
    this.actionEnabledListenable,
    this.actionListenable,
    this.header,
    this.headerHeight,
    this.onBackPressed,
    this.onClosePressed,
    this.backgroundColor = Colors.white,
    this.actionButtonColor,
    this.actionButtonStateListenable,
  });
}
