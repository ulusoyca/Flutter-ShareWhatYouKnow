import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-02-ensure-visible/widgets/shape_border_listview_02.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_section_title.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapedColorList extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<String> selectedColorCodeNotifier;

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
  final ScrollController _scrollController = ScrollController();
  final random = Random();
  List<EdgeInsets> paddings;

  int get selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) => element.toHex() == widget.selectedColorCodeNotifier.value);
    return index > -1 ? index : 0;
  }

  List<GlobalKey> keys;

  @override
  void initState() {
    paddings = List.generate(
      widget.colors.length,
      (_) => EdgeInsets.symmetric(vertical: random.nextInt(widget.colors.length) * 16.0),
    );
    keys = [for (int i = 0; i < widget.colors.length; i++) GlobalKey()];
    widget.selectedColorCodeNotifier.addListener(() {
      if (_scrollController.hasClients) {
        _scrollToSelectedColor();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          _onUserScrolled(notification.metrics.pixels);
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < widget.colors.length; i++)
              Container(
                color: widget.colors[i].shade100,
                child: _section(context, i),
              )
          ],
        ),
      ),
    );
  }

  Widget _section(BuildContext context, int index) {
    final color = widget.colors[index];
    return Padding(
      key: keys[index],
      padding: paddings[index],
      child: Column(
        children: [
          ColorSectionTitle(title: color.toHex(leadingHashSign: true)),
          ShapeBorderListView(
            sectionColor: color,
            selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
            selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
          ),
        ],
      ),
    );
  }

  void _onUserScrolled(double offset) {
    double totalItemHeight = 0;
    for (int i = 0; i < widget.colors.length; i++) {
      totalItemHeight += keys[i].currentContext.size.height;
      if (totalItemHeight > offset) {
        print("current index: $i");
        widget.selectedColorCodeNotifier.value = widget.colors[i].toHex();
        break;
      }
    }
  }

  void _scrollToSelectedColor() {
    Scrollable.ensureVisible(
      keys[selectedColorCodeIndex].currentContext,
      duration: Duration(milliseconds: selectedColorCodeIndex * 100),
      curve: Curves.easeInOut,
    );
  }
}
