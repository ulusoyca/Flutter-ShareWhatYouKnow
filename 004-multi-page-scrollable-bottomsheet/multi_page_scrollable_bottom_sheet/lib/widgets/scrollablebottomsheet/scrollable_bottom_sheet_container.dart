import 'package:flutter/material.dart';

class ScrollableBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const ScrollableBottomSheetContainer({
    Key? key,
    required this.child,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(24);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: radius, topRight: radius),
        color: backgroundColor,
      ),
      child: Container(
        child: child,
        color: backgroundColor,
      ),
    );
  }
}
