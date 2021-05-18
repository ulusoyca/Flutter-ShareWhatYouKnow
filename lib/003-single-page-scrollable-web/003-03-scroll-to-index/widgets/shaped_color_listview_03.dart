import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-03-scroll-to-index/widgets/shape_border_listview_03.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_section_title.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapedColorList extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<String> selectedColorCodeByUserScrollNotifier;
  final ValueListenable<String> selectedColorCodeByMenuClickNotifier;

  const ShapedColorList({
    Key key,
    @required this.colors,
    @required this.selectedShapeBorderTypeNotifier,
    @required this.selectedColorCodeByUserScrollNotifier,
    @required this.selectedColorCodeByMenuClickNotifier,
  }) : super(key: key);

  @override
  _ShapedColorListState createState() => _ShapedColorListState();
}

class _ShapedColorListState extends State<ShapedColorList> {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController _itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  int get leadingIndex {
    /// Determine the first visible item by finding the item with the
    /// smallest trailing edge that is greater than 0.  i.e. the first
    /// item whose trailing edge in visible in the viewport.
    final firstVisibleColorIndex = _itemPositionsListener.itemPositions.value
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;
    return firstVisibleColorIndex;
  }

  final random = Random();
  List<EdgeInsets> paddings;

  @override
  void initState() {
    paddings = List.generate(
      widget.colors.length,
      (_) => EdgeInsets.symmetric(vertical: random.nextInt(widget.colors.length) * 16.0),
    );
    _itemPositionsListener.itemPositions.addListener(() {
      widget.selectedColorCodeByUserScrollNotifier.value = widget.colors[leadingIndex].toHex();
    });
    widget.selectedColorCodeByMenuClickNotifier.addListener(() {
      if (_itemScrollController.isAttached) {
        int selectedColorIndex = _findIndexFromColorCode(widget.selectedColorCodeByMenuClickNotifier.value);
        _scrollTo(selectedColorIndex);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      initialScrollIndex: _findIndexFromColorCode(widget.selectedColorCodeByMenuClickNotifier.value),
      itemPositionsListener: _itemPositionsListener,
      itemCount: widget.colors.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: widget.colors[index].shade100,
          child: _section(context, index),
        );
      },
    );
  }

  Widget _section(BuildContext context, int index) {
    final color = widget.colors[index];
    return Padding(
      padding: paddings[index],
      child: Column(
        children: [
          ColorSectionTitle(title: color.toHex(leadingHashSign: true)),
          ShapeBorderListView(
            sectionColor: color,
            selectedColorCodeNotifier: widget.selectedColorCodeByMenuClickNotifier,
            selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
          ),
        ],
      ),
    );
  }

  int _findIndexFromColorCode(String value) {
    var indexWhere = widget.colors.indexWhere((element) => element.toHex() == value);
    return indexWhere == -1 ? 0 : indexWhere;
  }

  void _scrollTo(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: max(500, index * 100)),
      curve: Curves.easeInOutCubic,
    );
  }
}
