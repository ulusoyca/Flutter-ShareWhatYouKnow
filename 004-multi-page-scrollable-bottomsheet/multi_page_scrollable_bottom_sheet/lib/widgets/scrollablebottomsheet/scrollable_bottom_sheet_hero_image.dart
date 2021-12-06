import 'dart:math';

import 'package:flutter/material.dart';

class ScrollableBottomSheetHeroImage extends StatelessWidget {
  final Widget heroImage;
  final double topBarHeight;
  final double heroImageHeight;

  const ScrollableBottomSheetHeroImage({
    required this.heroImage,
    required this.topBarHeight,
    required this.heroImageHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _HeroImageFlowDelegate(
        scrollPosition: Scrollable.of(context)!.position,
        topBarHeight: topBarHeight,
        heroImageHeight: heroImageHeight,
      ),
      children: [heroImage],
    );
  }
}

class _HeroImageFlowDelegate extends FlowDelegate {
  _HeroImageFlowDelegate({
    required this.scrollPosition,
    required this.topBarHeight,
    required this.heroImageHeight,
  }) : super(repaint: scrollPosition);

  final ScrollPosition scrollPosition;
  final double topBarHeight;
  final double heroImageHeight;

  @override
  Size getSize(BoxConstraints constraints) {
    return super.getSize(constraints.copyWith(maxHeight: heroImageHeight));
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return super.getConstraintsForChild(
      i, // index of the child. In this case, the only child: hero image
      BoxConstraints.tight(Size(constraints.maxWidth, heroImageHeight)),
    );
  }

  @override
  void paintChildren(FlowPaintingContext flowPaintingContext) {
    final currentScrollPosition = scrollPosition.pixels;

    /// Calculate scale
    final _scaleStart = 1.1;
    final _scaleEnd = 1.0;
    double scale = _calculatePropertyValue(
      currentScrollPosition: currentScrollPosition,
      startPointInPx: 0,
      endPointInPx: heroImageHeight - topBarHeight,
      lowerLimit: min(_scaleStart, _scaleEnd),
      upperLimit: max(_scaleStart, _scaleEnd),
    );

    /// Calculate opacity
    final _opacityStart = 1.0;
    final _opacityEnd = 0.0;
    double opacity = _calculatePropertyValue(
      currentScrollPosition: currentScrollPosition,
      startPointInPx: (heroImageHeight / 2) - topBarHeight,
      endPointInPx: heroImageHeight - topBarHeight,
      lowerLimit: _opacityEnd,
      upperLimit: _opacityStart,
    );

    flowPaintingContext.paintChild(
      0,
      transform: Matrix4.diagonal3Values(scale, scale, 1.0),
      opacity: opacity,
    );
  }

  @override
  bool shouldRepaint(covariant _HeroImageFlowDelegate oldDelegate) {
    return heroImageHeight != oldDelegate.heroImageHeight ||
        topBarHeight != oldDelegate.topBarHeight;
  }

  double _calculatePropertyValue({
    required double currentScrollPosition,
    required double startPointInPx,
    required double endPointInPx,
    required double lowerLimit,
    required double upperLimit,
  }) {
    final distanceInPx = endPointInPx - startPointInPx;
    final progressInPx = currentScrollPosition - startPointInPx;
    final progress = progressInPx / distanceInPx;

    final rawValue = upperLimit - (progress * (upperLimit - lowerLimit));
    return rawValue.clamp(lowerLimit, upperLimit);
  }
}
