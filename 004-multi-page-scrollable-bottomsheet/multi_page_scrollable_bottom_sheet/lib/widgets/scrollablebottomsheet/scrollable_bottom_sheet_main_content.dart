import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_header.dart';

class ScrollableBottomSheetMainContent extends StatelessWidget {
  final ValueNotifier<double> currentScrollPosition;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final double topBarHeight;
  final double titleTopMargin;
  final GlobalKey titleKey;
  final Widget? header;
  final double? headerHeight;
  final Widget content;
  final bool hasActionButton;
  final Widget title;

  const ScrollableBottomSheetMainContent({
    Key? key,
    required this.currentScrollPosition,
    required this.edgeInsetsDirectional,
    required this.topBarHeight,
    required this.titleTopMargin,
    required this.titleKey,
    required this.header,
    required this.headerHeight,
    required this.content,
    required this.hasActionButton,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final header = this.header;
    final headerHeight = this.headerHeight;
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          currentScrollPosition.value = scrollNotification.metrics.pixels;
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: ScrollController(initialScrollOffset: currentScrollPosition.value),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: edgeInsetsDirectional.bottom + (true ? PrimaryButton.height : 0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (header != null && headerHeight != null)
                ScrollableBottomSheetHeader(
                  topBarHeight: topBarHeight,
                  child: header,
                  headerHeight: headerHeight,
                )
              else
                SizedBox(height: topBarHeight),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: edgeInsetsDirectional.start,
                  end: edgeInsetsDirectional.end,
                  top: header == null ? 0.0 : titleTopMargin,
                ),
                child: Container(
                  key: titleKey,
                  child: title,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: edgeInsetsDirectional.start,
                  end: edgeInsetsDirectional.end,
                ),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
