import 'package:flutter/material.dart';

class CurrentActionButtonAnimatedBuilder extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> _opacity;
  final Widget actionButton;

  CurrentActionButtonAnimatedBuilder({
    Key? key,
    required this.controller,
    required this.actionButton,
  })  : _opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              100 / 350,
              300 / 350,
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
          child: actionButton,
        );
      },
    );
  }
}
