import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/transformation_utils.dart';

class ScrollableBottomSheetTopBar extends StatelessWidget {
  final String topBarTitle;
  final double topBarHeight;
  final double? heroImageHeight;
  final Color backgroundColor;
  final ValueListenable<double> currentScrollPositionListenable;
  final GlobalKey titleKey;
  final double pageTitleTopPadding;
  final double topBarTranslationYAmountInPx;

  const ScrollableBottomSheetTopBar({
    required this.topBarTitle,
    required this.topBarHeight,
    required this.heroImageHeight,
    required this.backgroundColor,
    required this.currentScrollPositionListenable,
    required this.titleKey,
    required this.pageTitleTopPadding,
    required this.topBarTranslationYAmountInPx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _TopBarFlowDelegate(
        topBarHeight: topBarHeight,
        heroImageHeight: heroImageHeight,
        currentScrollPositionListenable: currentScrollPositionListenable,
        titleKey: titleKey,
        pageTitleTopPadding: pageTitleTopPadding,
        topBarTranslationYAmountInPx: topBarTranslationYAmountInPx,
      ),
      children: [
        _TopBar(backgroundColor: backgroundColor, height: topBarHeight),
        _TopBarTitle(title: topBarTitle),
      ],
    );
  }
}

class _TopBarFlowDelegate extends FlowDelegate {
  final double topBarHeight;
  final double? heroImageHeight;
  final ValueListenable<double> currentScrollPositionListenable;
  final GlobalKey titleKey;
  final double pageTitleTopPadding;
  final double topBarTranslationYAmountInPx;

  _TopBarFlowDelegate({
    required this.topBarHeight,
    required this.heroImageHeight,
    required this.currentScrollPositionListenable,
    required this.titleKey,
    required this.pageTitleTopPadding,
    required this.topBarTranslationYAmountInPx,
  }) : super(repaint: currentScrollPositionListenable);

  @override
  void paintChildren(FlowPaintingContext context) {
    final currentScrollPosition = currentScrollPositionListenable.value;
    final pageTitleHeight = titleKey.currentContext!.size!.height;

    final topBarTranslationYStart = 0.0;
    final topBarTranslationYEnd = topBarTranslationYAmountInPx;
    final totalTopBarTranslationYAmount = topBarTranslationYEnd - topBarTranslationYStart;
    final topBarTranslationYAndOpacityStartPoint = heroImageHeight == null
        ? 0
        : heroImageHeight! - totalTopBarTranslationYAmount - topBarHeight;

    final topBarTitleTranslationYStart = 0.0;
    final topBarTitleTranslationYEnd = 8.0;
    final totalTopBarTitleTranslationYAmount =
        topBarTitleTranslationYEnd - topBarTitleTranslationYStart;

    final topBarTitleTranslationYAndOpacityStartPoint = heroImageHeight == null
        ? totalTopBarTranslationYAmount + pageTitleTopPadding
        : heroImageHeight! - topBarHeight + pageTitleTopPadding;

    /// Top bar translation Y
    final topBarTranslationY = calculateTransformationValue(
      rangeInPx:
          totalTopBarTranslationYAmount + totalTopBarTitleTranslationYAmount + pageTitleHeight,
      progressInRangeInPx: currentScrollPosition - topBarTranslationYAndOpacityStartPoint,
      startValue: topBarTranslationYStart,
      endValue: topBarTranslationYEnd,
    );

    /// Top bar opacity
    final topBarOpacity = calculateTransformationValue(
      rangeInPx: totalTopBarTranslationYAmount + pageTitleTopPadding,
      progressInRangeInPx: currentScrollPosition - topBarTranslationYAndOpacityStartPoint,
      startValue: 0.0,
      endValue: 1.0,
    );

    /// Paint Top Bar
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, topBarTranslationY)).transform,
      opacity: topBarOpacity,
    );

    /// Top Bar Title translation Y
    final topBarTitleTranslationY = calculateTransformationValue(
      rangeInPx: totalTopBarTitleTranslationYAmount + pageTitleHeight - pageTitleTopPadding,
      progressInRangeInPx: currentScrollPosition - topBarTitleTranslationYAndOpacityStartPoint,
      startValue: topBarTitleTranslationYStart,
      endValue: topBarTitleTranslationYEnd,
    );

    /// Top Bar Title Opacity
    final topBarTitleOpacity = calculateTransformationValue(
      rangeInPx: pageTitleHeight * 0.75,
      progressInRangeInPx: currentScrollPosition - topBarTitleTranslationYAndOpacityStartPoint,
      startValue: 0.0,
      endValue: 1.0,
    );

    context.paintChild(
      1,
      transform: Transform.translate(
        offset: Offset(0.0, topBarTitleTranslationY),
      ).transform,
      opacity: topBarTitleOpacity,
    );
  }

  @override
  bool shouldRepaint(covariant _TopBarFlowDelegate oldDelegate) {
    return heroImageHeight != oldDelegate.heroImageHeight ||
        titleKey != oldDelegate.titleKey ||
        currentScrollPositionListenable != oldDelegate.currentScrollPositionListenable ||
        pageTitleTopPadding != oldDelegate.pageTitleTopPadding ||
        topBarTranslationYAmountInPx != oldDelegate.topBarTranslationYAmountInPx ||
        topBarHeight != oldDelegate.topBarHeight;
  }
}

class _TopBar extends StatelessWidget {
  final Color backgroundColor;
  final double height;

  const _TopBar({
    Key? key,
    required this.backgroundColor,
    required this.height,
  }) : super(key: key);

  final double elevation = 4.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: Container(height: height - elevation, color: backgroundColor),
    );
  }
}

class _TopBarTitle extends StatelessWidget {
  final String title;

  const _TopBarTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 60, left: 60, top: 24),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 1,
        ),
      ),
    );
  }
}
