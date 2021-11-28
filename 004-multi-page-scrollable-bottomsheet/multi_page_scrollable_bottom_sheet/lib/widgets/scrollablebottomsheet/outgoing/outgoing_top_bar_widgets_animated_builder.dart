import 'package:flutter/material.dart';

class OutgoingTopBarWidgetsAnimatedBuilder extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> _opacity;
  final Widget child;

  OutgoingTopBarWidgetsAnimatedBuilder({
    Key? key,
    required this.controller,
    required this.child,
  })  : _opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              100 / 350,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? _) {
        return Opacity(
          opacity: _opacity.value,
          child: child,
        );
      },
    );
  }
}
