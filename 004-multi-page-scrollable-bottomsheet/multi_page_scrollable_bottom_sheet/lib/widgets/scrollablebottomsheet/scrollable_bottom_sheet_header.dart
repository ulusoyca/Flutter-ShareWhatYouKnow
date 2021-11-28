import 'package:flutter/material.dart';

class ScrollableBottomSheetHeader extends StatelessWidget {
  final Widget child;
  final double topBarHeight;
  final double headerHeight;

  const ScrollableBottomSheetHeader({
    required this.child,
    required this.topBarHeight,
    required this.headerHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: headerHeight),
      child: Flow(
        delegate: _HeaderFlowDelegate(
          scrollable: Scrollable.of(context)!,
          headerContext: context,
          topBarHeight: topBarHeight,
          headerHeight: headerHeight,
        ),
        children: [child],
      ),
    );
  }
}

class _HeaderFlowDelegate extends FlowDelegate {
  _HeaderFlowDelegate({
    required this.scrollable,
    required this.headerContext,
    required this.topBarHeight,
    required this.headerHeight,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext headerContext;
  final double topBarHeight;
  final double headerHeight;
  final double _headerScaleStart = 1.1;
  final double _headerScaleEnd = 1;
  final double _headerOpacityStart = 1;
  final double _headerOpacityEnd = 0;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    // The header must be exactly as wide as the Flow widget.
    return BoxConstraints.tight(Size(constraints.maxWidth, headerHeight));
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final currentScrollPosition = scrollable.position.pixels;
    double headerScale = _calculateHeaderScale(currentScrollPosition);
    double opacity = _calculateHeaderOpacity(currentScrollPosition);
    context.paintChild(
      0,
      transform: Transform.scale(
        scale: headerScale,
        alignment: Alignment.bottomCenter,
      ).transform,
      opacity: opacity,
    );
  }

  @override
  bool shouldRepaint(covariant _HeaderFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        headerContext != oldDelegate.headerContext ||
        headerHeight != oldDelegate.headerHeight ||
        topBarHeight != oldDelegate.topBarHeight;
  }

  double _calculateHeaderScale(double currentScrollPosition) {
    final startPoint = headerHeight - topBarHeight;
    final distance = headerHeight - topBarHeight;
    final double progress = 1 - ((startPoint - currentScrollPosition) / distance);
    final double rawHeaderScale =
        _headerScaleStart - (progress * (_headerScaleStart - _headerScaleEnd));
    return rawHeaderScale.clamp(
      _headerScaleEnd,
      _headerScaleStart,
    );
  }

  double _calculateHeaderOpacity(double currentScrollPosition) {
    final double distance = headerHeight / 2;
    final double startPoint = headerHeight - topBarHeight;
    final rawOpacity = ((startPoint - currentScrollPosition) / distance);
    return rawOpacity.clamp(
      _headerOpacityEnd,
      _headerOpacityStart,
    );
  }
}
