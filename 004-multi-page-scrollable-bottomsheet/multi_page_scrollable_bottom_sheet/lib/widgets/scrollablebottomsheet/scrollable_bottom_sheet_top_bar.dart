import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollableBottomSheetTopBar extends StatelessWidget {
  final String topBarTitle;
  final double topBarHeight;
  final double? headerHeight;
  final Color backgroundColor;
  final ValueListenable<double> currentScrollPositionListenable;
  final GlobalKey titleKey;

  final double _topBarTranslationYStart = 0;

  final double _topBarTranslationYEnd = 4;

  final double _topBarTitleTranslationYStart = 0;

  final double _topBarTitleTranslationYEnd = 8;

  const ScrollableBottomSheetTopBar({
    required this.topBarTitle,
    required this.topBarHeight,
    required this.headerHeight,
    required this.backgroundColor,
    required this.currentScrollPositionListenable,
    required this.titleKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _TopBarFlowDelegate(
        topBarHeight: topBarHeight,
        headerHeight: headerHeight,
        currentScrollPositionListenable: currentScrollPositionListenable,
        titleKey: titleKey,
        topBarTranslationYStart: _topBarTranslationYStart,
        topBarTranslationYEnd: _topBarTranslationYEnd,
        topBarTitleTranslationYStart: _topBarTitleTranslationYStart,
        topBarTitleTranslationYEnd: _topBarTitleTranslationYEnd,
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
  final double? headerHeight;
  final ValueListenable<double> currentScrollPositionListenable;
  final GlobalKey titleKey;
  final double topBarTranslationYEnd;
  final double topBarTranslationYStart;
  final double topBarTitleTranslationYEnd;
  final double topBarTitleTranslationYStart;

  _TopBarFlowDelegate({
    required this.topBarHeight,
    required this.headerHeight,
    required this.currentScrollPositionListenable,
    required this.titleKey,
    required this.topBarTranslationYStart,
    required this.topBarTranslationYEnd,
    required this.topBarTitleTranslationYStart,
    required this.topBarTitleTranslationYEnd,
  }) : super(repaint: currentScrollPositionListenable);

  final double _topBarOpacityStart = 0;
  final double _topBarOpacityEnd = 1;

  double get _topBarTranslationYDistance => topBarTranslationYEnd - topBarTranslationYStart;
  final double _topBarTitleOpacityStart = 0;
  final double _topBarTitleOpacityEnd = 1;

  double get _topBarTitleTranslationYDistance =>
      topBarTitleTranslationYEnd - topBarTitleTranslationYStart;

  @override
  void paintChildren(FlowPaintingContext context) {
    final currentScrollPosition = currentScrollPositionListenable.value;
    final bigTitleHeight = titleKey.currentContext!.size!.height;

    /// Paint Top Bar
    final topBarOpacity = _calculateTopBarOpacity(currentScrollPosition);
    final topBarTranslationY = _calculateTopBarTranslationY(
      currentScrollPosition,
      bigTitleHeight,
    );
    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0.0, topBarTranslationY),
      ).transform,
      opacity: topBarOpacity,
    );

    /// Paint Top Bar Title
    final topBarTitleOpacity = _calculateTopBarTitleOpacity(currentScrollPosition, bigTitleHeight);
    final topBarTitleTranslationY =
        _calculateTopBarTitleTranslationY(currentScrollPosition, bigTitleHeight);
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
    return headerHeight != oldDelegate.headerHeight ||
        titleKey != oldDelegate.titleKey ||
        currentScrollPositionListenable != oldDelegate.currentScrollPositionListenable ||
        topBarHeight != oldDelegate.topBarHeight;
  }

  double _calculateTopBarTitleOpacity(double currentScrollPosition, double bigTitleHeight) {
    final double distance = 0.75 * bigTitleHeight;
    final headerHeight = this.headerHeight;
    final double startPoint = headerHeight == null
        ? _topBarTitleTranslationYDistance + _topBarTranslationYDistance
        : headerHeight - topBarHeight + _topBarTitleTranslationYDistance;
    final double progress = (currentScrollPosition - startPoint) / distance;
    return progress.clamp(_topBarTitleOpacityStart, _topBarTitleOpacityEnd);
  }

  _calculateTopBarOpacity(double currentScrollPosition) {
    final double distance = _topBarTitleTranslationYDistance + _topBarTranslationYDistance;
    final headerHeight = this.headerHeight;
    final double startPoint =
        headerHeight == null ? 0 : headerHeight - topBarHeight - _topBarTranslationYDistance;
    final double progress = (currentScrollPosition - startPoint) / distance;
    return progress.clamp(_topBarOpacityStart, _topBarOpacityEnd);
  }

  double _calculateTopBarTranslationY(double currentScrollPosition, double bigTitleHeight) {
    final double distance =
        bigTitleHeight + _topBarTranslationYDistance + _topBarTitleTranslationYDistance;
    final headerHeight = this.headerHeight;
    final double startPoint =
        headerHeight == null ? 0 : headerHeight - topBarHeight - _topBarTranslationYDistance;
    final double progress = (currentScrollPosition - startPoint) / distance;
    final double topBarTranslationY = topBarTranslationYEnd * progress;
    print("topBarTranslationY $topBarTranslationY");
    return topBarTranslationY.clamp(
      topBarTranslationYStart,
      topBarTranslationYEnd,
    );
  }

  double _calculateTopBarTitleTranslationY(double currentScrollPosition, double bigTitleHeight) {
    final double distance = bigTitleHeight;
    final headerHeight = this.headerHeight;
    final double startPoint = headerHeight == null
        ? _topBarTitleTranslationYDistance + _topBarTranslationYDistance
        : headerHeight - topBarHeight + _topBarTitleTranslationYDistance;
    final double progress = (currentScrollPosition - startPoint) / distance;
    final double topBarTitleTranslationY = topBarTitleTranslationYEnd * progress;
    return topBarTitleTranslationY.clamp(
      topBarTitleTranslationYStart,
      topBarTitleTranslationYEnd,
    );
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 4.0,
        child: Container(
          height: height,
          color: backgroundColor,
        ),
      ),
    );
  }
}

class _TopBarTitle extends StatelessWidget {
  final String title;

  const _TopBarTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 60, left: 60, top: 20),
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
