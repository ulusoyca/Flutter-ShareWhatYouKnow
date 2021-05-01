import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_section_title.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'shape_border_listview_01.dart';

class ShapedColorList extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueListenable<String> selectedColorCodeNotifier;

  const ShapedColorList({
    Key key,
    @required this.colors,
    @required this.selectedShapeBorderTypeNotifier,
    @required this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  _ShapedColorListState createState() => _ShapedColorListState();
}

class _ShapedColorListState extends State<ShapedColorList> {
  ScrollController _scrollController = ScrollController();

  double itemHeight = 0;

  int get selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) => element.toHex() == widget.selectedColorCodeNotifier.value);
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    widget.selectedColorCodeNotifier.addListener(() {
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
              child: Container(
                color: color.shade100,
                child: _section(color, context),
              ),
            );
          },
        );
      },
    );
  }

  Column _section(MaterialColor color, BuildContext context) {
    return Column(
      children: [
        ColorSectionTitle(title: color.toHex(leadingHashSign: true)),
        Expanded(
          child: ShapeBorderListView(
            sectionColor: color,
            selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
            selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
          ),
        ),
      ],
    );
  }

  void _scrollToSelectedColor() {
    _scrollController.animateTo(
      selectedColorCodeIndex * itemHeight,
      duration: Duration(milliseconds: max(500, selectedColorCodeIndex * 100)),
      curve: Curves.easeInOut,
    );
  }
}
