import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shape_border_gridview.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapedColorList extends StatefulWidget {
  final List<Color> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderType;
  final ValueNotifier<String> selectedColorCode;
  final ValueListenable<String> colorCodeFromBrowserHistory;

  const ShapedColorList({
    Key key,
    @required this.colors,
    @required this.selectedShapeBorderType,
    @required this.selectedColorCode,
    @required this.colorCodeFromBrowserHistory,
  }) : super(key: key);

  @override
  _ShapedColorListState createState() => _ShapedColorListState();
}

class _ShapedColorListState extends State<ShapedColorList> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    widget.colorCodeFromBrowserHistory.addListener(() {
      _scrollTo(widget.colorCodeFromBrowserHistory.value);
    });
    widget.selectedColorCode.addListener(() {
      _scrollTo(widget.selectedColorCode.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      initialScrollIndex: _findIndexFromColorCode(widget.selectedColorCode.value),
      itemCount: widget.colors.length,
      itemBuilder: (BuildContext context, int index) {
        final color = widget.colors[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(color.toHex(leadingHashSign: true), style: Theme.of(context).textTheme.headline5),
              ShapeBorderGridView(
                color: color,
                onShapeTap: (ShapeBorderType type) {
                  widget.selectedColorCode.value = color.toHex(leadingHashSign: false);
                  widget.selectedShapeBorderType.value = type;
                },
                scrollPhysics: NeverScrollableScrollPhysics(),
                sliverGridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 4,
                  mainAxisExtent: 120,
                ),
              ),
              Divider(thickness: 2),
            ],
          ),
        );
      },
    );
  }

  int _findIndexFromColorCode(String value) {
    var indexWhere = widget.colors.indexWhere((element) => element.toHex() == value);
    return indexWhere == -1 ? 0 : indexWhere;
  }

  void _scrollTo(String value) {
    int index = _findIndexFromColorCode(value);
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOutCubic,
    );
  }
}
