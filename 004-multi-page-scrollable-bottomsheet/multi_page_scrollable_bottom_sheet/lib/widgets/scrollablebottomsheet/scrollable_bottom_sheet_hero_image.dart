import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/transformation_utils.dart';

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
    double scale = calculateTransformationValue(
        startValue: 1.1,
        endValue: 1.0,
        rangeInPx: heroImageHeight - topBarHeight,
        progressInRangeInPx: currentScrollPosition);

    /// Calculate opacity
    double opacity = calculateTransformationValue(
      rangeInPx: heroImageHeight / 2,
      progressInRangeInPx: currentScrollPosition - ((heroImageHeight / 2) - topBarHeight),
      startValue: 1.0,
      endValue: 0.0,
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
        scrollPosition != oldDelegate.scrollPosition ||
        topBarHeight != oldDelegate.topBarHeight;
  }
}
