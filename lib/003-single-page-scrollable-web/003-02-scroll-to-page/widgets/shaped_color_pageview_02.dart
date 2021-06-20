import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'shape_border_listview_02.dart';

class ShapedColorPageView extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<ColorCodeSelection> selectedColorCodeNotifier;

  const ShapedColorPageView({
    Key key,
    @required this.colors,
    @required this.selectedShapeBorderTypeNotifier,
    @required this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  _ShapedColorPageViewState createState() => _ShapedColorPageViewState();
}

class _ShapedColorPageViewState extends State<ShapedColorPageView> {
  PageController _pageController = PageController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients && widget.selectedColorCodeNotifier.value != null) {
        _scrollToSelectedColor();
      }
    });
    widget.selectedColorCodeNotifier.addListener(() {
      final fromButtonClick = widget.selectedColorCodeNotifier.value.source == ColorCodeSelectionSource.fromButtonClick;
      if (_pageController.hasClients && fromButtonClick) {
        _scrollToSelectedColor();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _updateScrollController(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          _onUserScroll();
        }
        return true;
      },
      child: PageView.builder(
        pageSnapping: false,
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.colors.length,
        itemBuilder: (BuildContext context, int index) {
          final color = widget.colors[index];
          return Container(
            color: color.shade100,
            child: _section(color, context),
          );
        },
      ),
    );
  }

  void _updateScrollController(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight <= 800) {
      _pageController = PageController(viewportFraction: 800 / screenHeight);
    } else {
      _pageController = PageController(viewportFraction: 1);
    }
  }

  void _onUserScroll() {
    final hexColorCode = widget.colors[_pageController.page.floor()].toHex();
    widget.selectedColorCodeNotifier.value = ColorCodeSelection(
      hexColorCode: hexColorCode,
      source: ColorCodeSelectionSource.fromScroll,
    );
  }

  Widget _section(MaterialColor color, BuildContext context) {
    return ShapeBorderListView(
      sectionColor: color,
      selectedShapeBorderTypeNotifier: widget.selectedShapeBorderTypeNotifier,
      selectedColorCodeNotifier: widget.selectedColorCodeNotifier,
    );
  }

  void _scrollToSelectedColor() {
    int index = widget.colors.indexWhere((element) {
      final selectedHexColorCode = widget.selectedColorCodeNotifier.value.hexColorCode;
      return element.toHex() == selectedHexColorCode;
    });
    int selectedColorCodeIndex = index > -1 ? index : 0;
    _pageController.animateToPage(
      selectedColorCodeIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
