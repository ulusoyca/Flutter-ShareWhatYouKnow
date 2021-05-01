import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'shape_border_listview.dart';

class ShapedColorList extends StatefulWidget {
  final List<Color> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderType;
  final ValueNotifier<double> scrollPosition;
  final ValueListenable<String> selectedColorCode;

  const ShapedColorList({
    Key key,
    @required this.colors,
    @required this.selectedShapeBorderType,
    @required this.scrollPosition,
    @required this.selectedColorCode,
  }) : super(key: key);

  @override
  _ShapedColorListState createState() => _ShapedColorListState();
}

class _ShapedColorListState extends State<ShapedColorList> {
  ScrollController _scrollController;

  double itemHeight = 0;

  int get selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) => element.toHex() == widget.selectedColorCode.value);
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: widget.scrollPosition.value);

    _scrollController.addListener(() {
      widget.scrollPosition.value = _scrollController.position.pixels;
    });

    widget.selectedColorCode.addListener(() {
      if (_scrollController.hasClients) {
        _scrollToSelectedColor();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final minItemHeight = 700.0;
        itemHeight = max(constraints.maxHeight, minItemHeight);
        return ListView.builder(
          controller: _scrollController,
          itemCount: widget.colors.length,
          itemBuilder: (BuildContext context, int index) {
            final color = widget.colors[index];
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: max(constraints.maxHeight, minItemHeight),
                minHeight: minItemHeight,
                minWidth: 600,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(color.toHex(leadingHashSign: true), style: Theme.of(context).textTheme.headline4),
                  ),
                  Expanded(
                    child: ShapeBorderListView(
                      sectionColor: color,
                      selectedShapeBorderType: widget.selectedShapeBorderType,
                    ),
                  ),
                  Divider(thickness: 2),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _scrollToSelectedColor() {
    _scrollController.animateTo(
      selectedColorCodeIndex * itemHeight,
      duration: Duration(milliseconds: max(500, selectedColorCodeIndex * 100)),
      curve: Curves.linear,
    );
  }
}
