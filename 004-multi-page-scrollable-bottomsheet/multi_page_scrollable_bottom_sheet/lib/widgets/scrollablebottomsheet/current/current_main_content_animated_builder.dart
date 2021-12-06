import 'package:flutter/material.dart';

class CurrentMainContentAnimatedBuilder extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> _opacity;
  final GlobalKey outgoingOffstagedMainContentKey;
  final GlobalKey currentOffstagedMainContentKey;
  final Widget mainContent;
  final bool forwardMove;

  CurrentMainContentAnimatedBuilder({
    Key? key,
    required this.controller,
    required this.mainContent,
    required this.outgoingOffstagedMainContentKey,
    required this.currentOffstagedMainContentKey,
    required this.forwardMove,
  })  : _opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              150 / 350,
              350 / 350,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  @override
  State<CurrentMainContentAnimatedBuilder> createState() =>
      _CurrentMainContentAnimatedBuilderState();
}

class _CurrentMainContentAnimatedBuilderState extends State<CurrentMainContentAnimatedBuilder> {
  late Animation<double> _sizeFactor;
  bool firstTick = true;

  @override
  void initState() {
    super.initState();
    _sizeFactor = Tween<double>(begin: 0.0, end: 1.0).animate(widget.controller);
    widget.controller.addListener(() {
      if (firstTick) {
        final currentHeight = widget.currentOffstagedMainContentKey.currentContext!.size!.height;
        final outgoingHeight = widget.outgoingOffstagedMainContentKey.currentContext!.size!.height;
        _sizeFactor = Tween<double>(begin: outgoingHeight / currentHeight, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: const Interval(0 / 350, 300 / 350, curve: Curves.fastOutSlowIn),
          ),
        );
        firstTick = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? _) {
        return SizeTransition(
          axis: Axis.vertical,
          axisAlignment: -1,
          sizeFactor: _sizeFactor,
          child: Opacity(
            opacity: widget._opacity.value,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(80 * (widget.forwardMove ? 1 : -1) / constraints.maxWidth, 0),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: widget.controller,
                      curve: const Interval(
                        50 / 350,
                        350 / 350,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                  child: widget.mainContent,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
