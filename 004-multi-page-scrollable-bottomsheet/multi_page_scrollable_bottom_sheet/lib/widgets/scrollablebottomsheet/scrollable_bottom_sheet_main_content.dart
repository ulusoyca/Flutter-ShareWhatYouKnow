import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_hero_image.dart';

class ScrollableBottomSheetMainContent extends StatelessWidget {
  final ValueNotifier<double> currentScrollPosition;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final double topBarHeight;
  final GlobalKey titleKey;
  final Widget? heroImage;
  final double? heroImageHeight;
  final Widget content;
  final bool hasActionButton;
  final Widget title;
  final double titleTopPadding;

  const ScrollableBottomSheetMainContent({
    Key? key,
    required this.currentScrollPosition,
    required this.edgeInsetsDirectional,
    required this.topBarHeight,
    required this.titleKey,
    required this.heroImage,
    required this.heroImageHeight,
    required this.content,
    required this.hasActionButton,
    required this.title,
    required this.titleTopPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              if (heroImage != null && heroImageHeight != null)
                ScrollableBottomSheetHeroImage(
                  topBarHeight: topBarHeight,
                  heroImage: heroImage!,
                  heroImageHeight: heroImageHeight!,
                )
              else
                SizedBox(height: topBarHeight),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: edgeInsetsDirectional.start,
                  end: edgeInsetsDirectional.end,
                  top: titleTopPadding,
                ),
                child: KeyedSubtree(
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
