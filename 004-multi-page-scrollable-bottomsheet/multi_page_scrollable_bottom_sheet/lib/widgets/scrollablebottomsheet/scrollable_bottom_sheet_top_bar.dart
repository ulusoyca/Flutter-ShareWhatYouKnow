import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollableBottomSheetTopBar extends StatelessWidget {
  final Text topBarTitle;
  final double topBarHeight;
  final double availableTopSpace;
  final double titleTopMargin;
  final Color backgroundColor;
  final ValueListenable<double> currentScrollPositionListenable;
  final GlobalKey titleKey;

  final double _topBarTranslationYStart = 0;

  final double _topBarTranslationYEnd = 4;

  const ScrollableBottomSheetTopBar({
    required this.topBarTitle,
    required this.topBarHeight,
    required this.availableTopSpace,
    required this.titleTopMargin,
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
        availableTopSpace: availableTopSpace,
        bigTitleTopMargin: titleTopMargin,
        currentScrollPositionListenable: currentScrollPositionListenable,
        titleKey: titleKey,
        topBarTranslationYStart: _topBarTranslationYStart,
        topBarTranslationYEnd: _topBarTranslationYEnd,
      ),
      children: [
        _TopBar(
          backgroundColor: backgroundColor,
          height: topBarHeight,
          availableTopSpace: availableTopSpace,
          currentScrollPositionListenable: currentScrollPositionListenable,
          titleTopMargin: titleTopMargin,
          topBarHeight: topBarHeight,
          topBarTranslationYDistance: _topBarTranslationYEnd - _topBarTranslationYStart,
        ),
        _TopBarTitle(child: topBarTitle)
      ],
    );
  }
}

class _TopBarFlowDelegate extends FlowDelegate {
  final double topBarHeight;
  final double availableTopSpace;
  final double bigTitleTopMargin;
  final ValueListenable<double> currentScrollPositionListenable;
  final GlobalKey titleKey;
  final double topBarTranslationYEnd;
  final double topBarTranslationYStart;

  _TopBarFlowDelegate({
    required this.topBarHeight,
    required this.availableTopSpace,
    required this.bigTitleTopMargin,
    required this.currentScrollPositionListenable,
    required this.titleKey,
    required this.topBarTranslationYStart,
    required this.topBarTranslationYEnd,
  }) : super(repaint: currentScrollPositionListenable);

  final double _topBarOpacityStart = 0;
  final double _topBarOpacityEnd = 1;

  double get _topBarTranslationYDistance => topBarTranslationYEnd - topBarTranslationYStart;

  final double _topBarTitleOpacityStart = 0;
  final double _topBarTitleOpacityEnd = 1;

  final double _topBarTitleTranslationYStart = 0;

  final double _topBarTitleTranslationYEnd = 8;

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
    final topBarTitleTranslationY = _calculateTopBarTitleTranslationY(
      currentScrollPosition,
      bigTitleHeight,
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
    return availableTopSpace != oldDelegate.availableTopSpace ||
        bigTitleTopMargin != oldDelegate.bigTitleTopMargin ||
        titleKey != oldDelegate.titleKey ||
        currentScrollPositionListenable != oldDelegate.currentScrollPositionListenable ||
        topBarHeight != oldDelegate.topBarHeight;
  }

  double _calculateTopBarTitleOpacity(double currentScrollPosition, double bigTitleHeight) {
    final double distance = 0.75 * bigTitleHeight;
    final double startPoint = availableTopSpace - topBarHeight + bigTitleTopMargin + distance;
    final double progress = (startPoint - currentScrollPosition) / distance;
    final double topBarTitleOpacityProgress = _topBarTitleOpacityEnd - progress;
    return topBarTitleOpacityProgress.clamp(_topBarTitleOpacityStart, _topBarTitleOpacityEnd);
  }

  _calculateTopBarOpacity(double currentScrollPosition) {
    final double distance = bigTitleTopMargin + _topBarTranslationYDistance;
    final double startPoint = availableTopSpace - topBarHeight + bigTitleTopMargin;
    final double progress = (startPoint - currentScrollPosition) / distance;
    final double topBarOpacity = _topBarOpacityEnd - progress;
    return topBarOpacity.clamp(_topBarOpacityStart, _topBarOpacityEnd);
  }

  double _calculateTopBarTranslationY(double currentScrollPosition, double bigTitleHeight) {
    final double distance = bigTitleHeight;
    final topBarTranslationYDistanceLp = _topBarTranslationYDistance;
    final double startPoint =
        availableTopSpace - topBarHeight + topBarTranslationYDistanceLp + distance;
    final double progress = (startPoint - currentScrollPosition) / distance;
    final double topBarTranslationY = topBarTranslationYEnd * progress;
    return -1 *
        topBarTranslationY.clamp(
          topBarTranslationYStart,
          topBarTranslationYEnd,
        );
  }

  double _calculateTopBarTitleTranslationY(double currentScrollPosition, double bigTitleHeight) {
    final double distance = bigTitleTopMargin + bigTitleHeight;
    final double startPoint = (availableTopSpace - topBarHeight) + distance;
    final double progress = (startPoint - currentScrollPosition) / distance;
    final double topBarTitleTranslationY = _topBarTitleTranslationYEnd * progress;
    return -1 *
        topBarTitleTranslationY.clamp(
          _topBarTitleTranslationYStart,
          _topBarTitleTranslationYEnd,
        );
  }
}

class _TopBar extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final ValueListenable<double> currentScrollPositionListenable;
  final double titleTopMargin;
  final double topBarTranslationYDistance;
  final double availableTopSpace;
  final double topBarHeight;

  final double _elevationStart = 0;
  final double _elevationEnd = 4;

  const _TopBar({
    Key? key,
    required this.backgroundColor,
    required this.height,
    required this.currentScrollPositionListenable,
    required this.titleTopMargin,
    required this.topBarTranslationYDistance,
    required this.availableTopSpace,
    required this.topBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentScrollPositionListenable,
      builder: (BuildContext context, double value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Material(
            elevation: _calculateTopBarElevation(context),
            child: Container(
              height: height,
              color: backgroundColor,
            ),
          ),
        );
      },
    );
  }

  double _calculateTopBarElevation(BuildContext context) {
    final double distance = titleTopMargin + topBarTranslationYDistance;
    final double startPoint = availableTopSpace - topBarHeight + titleTopMargin;
    final double progress = (startPoint - currentScrollPositionListenable.value) / distance;
    final double topBarElevationProgress = progress * (_elevationEnd - _elevationStart);
    return _elevationEnd - topBarElevationProgress.clamp(_elevationStart, _elevationEnd);
  }
}

class _TopBarTitle extends StatelessWidget {
  final Text child;

  const _TopBarTitle({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 60, left: 60, top: 32),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          child.data ?? '',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 1,
        ),
      ),
    );
  }
}
