import 'package:flutter/material.dart';

class OutgoingMainContentAnimatedBuilder extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> _opacity;
  final GlobalKey outgoingMainContentKey;
  final GlobalKey currentMainContentKey;
  final Widget mainContent;

  OutgoingMainContentAnimatedBuilder({
    Key? key,
    required this.controller,
    required this.mainContent,
    required this.outgoingMainContentKey,
    required this.currentMainContentKey,
  })  : _opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              50 / 350,
              150 / 350,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  @override
  State<OutgoingMainContentAnimatedBuilder> createState() =>
      _OutgoingMainContentAnimatedBuilderState();
}

class _OutgoingMainContentAnimatedBuilderState extends State<OutgoingMainContentAnimatedBuilder> {
  late Animation<double> _sizeFactor;
  bool firstTick = true;

  @override
  void initState() {
    super.initState();
    _sizeFactor = Tween<double>(begin: 1.0, end: 0.0).animate(widget.controller);
    widget.controller.addListener(() {
      if (firstTick) {
        final currentHeight = widget.currentMainContentKey.currentContext!.size!.height;
        final outgoingHeight = widget.outgoingMainContentKey.currentContext!.size!.height;
        _sizeFactor = Tween<double>(
          begin: 1.0,
          end: currentHeight / outgoingHeight,
        ).animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: const Interval(
              0 / 350,
              300 / 350,
              curve: Curves.fastOutSlowIn,
            ),
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
          axisAlignment: 1,
          sizeFactor: _sizeFactor,
          child: Opacity(
            opacity: widget._opacity.value,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0),
                    end: Offset(-80 / constraints.maxWidth, 0),
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
