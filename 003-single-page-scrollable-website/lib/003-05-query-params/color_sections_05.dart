import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:single_page_scrollable_website/003-05-query-params/shape_border_listview_05.dart';
import 'package:single_page_scrollable_website/entity/color_code.dart';
import 'package:single_page_scrollable_website/widgets/color_section_title.dart';
import 'package:single_page_scrollable_website/widgets/lorem_text.dart';

class ColorSections extends StatefulWidget {
  final List<MaterialColor>? colors;
  final ValueNotifier<ShapeBorderType?>? shapeBorderTypeNotifier;
  final ValueNotifier<ColorCode?>? colorCodeNotifier;

  const ColorSections({
    Key? key,
    required this.colors,
    required this.shapeBorderTypeNotifier,
    required this.colorCodeNotifier,
  }) : super(key: key);

  @override
  _ColorSectionsState createState() => _ColorSectionsState();
}

class _ColorSectionsState extends State<ColorSections> {
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

  int get colorCodeIndex {
    int index = widget.colors!.indexWhere((element) {
      final hexColorCode = widget.colorCodeNotifier!.value?.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollToIndex();
      widget.colorCodeNotifier!.addListener(() {
        final fromScroll =
            widget.colorCodeNotifier!.value?.source == ColorCodeSelectionSource.fromScroll;
        if (_itemScrollController.isAttached && !fromScroll) {
          _scrollToIndex();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          widget.colorCodeNotifier!.value = ColorCode(
            hexColorCode: widget.colors![trailingIndex].toHex(),
            source: ColorCodeSelectionSource.fromScroll,
          );
        }
        return true;
      },
      child: _scrollablePositionedList(),
    );
  }

  ScrollablePositionedList _scrollablePositionedList() {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemCount: widget.colors!.length,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: widget.colors![index].shade100,
          child: _section(context, index),
        );
      },
    );
  }

  Widget _section(BuildContext context, int index) {
    final color = widget.colors![index];
    return Container(
      color: color.shade100,
      padding: const EdgeInsets.all(64),
      child: Column(
        children: [
          ColorSectionTitle(title: color.toHex(leadingHashSign: true)),
          ShapeBorderListView(
            sectionColor: color,
            colorCodeNotifier: widget.colorCodeNotifier,
            shapeBorderTypeNotifier: widget.shapeBorderTypeNotifier,
          ),
          LoremText(seed: index),
        ],
      ),
    );
  }

  void _scrollToIndex() {
    _itemScrollController.scrollTo(
      index: colorCodeIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }
}
