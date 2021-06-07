import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-02-ensure-visible/widgets/shape_border_listview_02.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/color_section_title.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/lorem_text.dart';
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
  final ScrollController _scrollController = ScrollController();
  List<GlobalKey> keys;

  int get selectedColorCodeIndex {
    int index = widget.colors.indexWhere((element) {
      final hexColorCode = widget.selectedColorCodeNotifier.value.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    keys = [for (int i = 0; i < widget.colors.length; i++) GlobalKey()];
    widget.selectedColorCodeNotifier.addListener(() {
      final fromScroll = widget.selectedColorCodeNotifier.value.source == ColorCodeSelectionSource.fromScroll;
      if (_scrollController.hasClients && !fromScroll) {
        _scrollToSelectedColor();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          _onUserScrolled(notification.metrics.pixels);
        }
        return true;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [for (int i = 0; i < widget.colors.length; i++) _section(context, i)],
        ),
      ),
    );
  }

  Widget _section(BuildContext context, int index) {
    final color = widget.colors[index];
    final key = keys[index];
    return Container(
      key: key,
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

  void _onUserScrolled(double offset) {
    double totalItemHeight = 0;
    for (int i = 0; i < keys.length; i++) {
      totalItemHeight += keys[i].currentContext.size.height;
      if (totalItemHeight > offset) {
        final color = widget.colors[i];
        widget.selectedColorCodeNotifier.value = ColorCodeSelection(
          hexColorCode: color.toHex(),
          source: ColorCodeSelectionSource.fromScroll,
        );
        break;
      }
    }
  }

  void _scrollToSelectedColor() {
    Scrollable.ensureVisible(
      keys[selectedColorCodeIndex].currentContext,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
