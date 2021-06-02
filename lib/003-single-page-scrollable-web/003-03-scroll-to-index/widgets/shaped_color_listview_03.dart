import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-03-scroll-to-index/widgets/shape_border_listview_03.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_section_title.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/lorem_text.dart';
import 'package:ulusoyapps_flutter/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapedColorList extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<ColorCodeSelection> selectedColorCodeNotifier;

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
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController _itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  int get trailingIndex {
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

  int get selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) {
      final hexColorCode = widget.selectedColorCodeNotifier.value.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    widget.selectedColorCodeNotifier.addListener(() {
      if (_itemScrollController.isAttached) {
        _scrollToIndex();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          final color = widget.colors[trailingIndex];
          widget.selectedColorCodeNotifier.value = ColorCodeSelection(
            hexColorCode: color.toHex(),
            fromScroll: true,
          );
        }
        return true;
      },
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemPositionsListener: _itemPositionsListener,
        itemCount: widget.colors.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: widget.colors[index].shade100,
            child: _section(context, index),
          );
        },
      ),
    );
  }

  Widget _section(BuildContext context, int index) {
    final color = widget.colors[index];
    return Container(
      color: color.shade100,
      padding: const EdgeInsets.all(64),
      child: Column(
        children: [
          ColorSectionTitle(title: color.toHex(leadingHashSign: true)),
          ShapeBorderListView(
            sectionColor: color,
            selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
            selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
          ),
          LoremText(key: ValueKey(index)),
        ],
      ),
    );
  }

  void _scrollToIndex() {
    _itemScrollController.scrollTo(
      index: selectedColorCodeIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
}
