import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:single_page_scrollable_website/003-02-scroll-to-page/shape_border_listview_02.dart';
import 'package:single_page_scrollable_website/entity/color_code.dart';

class ColorSections extends StatefulWidget {
  final List<MaterialColor> colors;
  final ValueNotifier<ShapeBorderType?> shapeBorderTypeNotifier;
  final ValueNotifier<ColorCode?> colorCodeNotifier;

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
  final double _minPageHeight = 600;

  PageController _pageController = PageController();

  // Find the index of the color code from the colors list
  int get _colorCodeIndex {
    final hexColorCode = widget.colorCodeNotifier.value?.hexColorCode;
    int index = widget.colors.indexWhere((element) {
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    super.initState();
    widget.colorCodeNotifier.addListener(() {
      final fromScroll =
          widget.colorCodeNotifier.value?.source == ColorCodeSelectionSource.fromScroll;
      if (_pageController.hasClients && !fromScroll) {
        _pageController.animateToPage(
          _colorCodeIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final availableHeight = constraints.maxHeight;
        _updatePageController(availableHeight);
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is UserScrollNotification) {
              _onUserScroll();
            }
            return true;
          },
          child: _pageView(),
        );
      },
    );
  }

  PageView _pageView() {
    return PageView.builder(
      pageSnapping: false,
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: widget.colors.length,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final color = widget.colors[index];
        return Container(
          color: color.shade100,
          child: ShapeBorderListView(
            sectionColor: color,
            shapeBorderTypeNotifier: widget.shapeBorderTypeNotifier,
            colorCodeNotifier: widget.colorCodeNotifier,
          ),
        );
      },
    );
  }

  void _updatePageController(double availableHeight) {
    if (availableHeight < _minPageHeight) {
      _pageController = PageController(
        viewportFraction: _minPageHeight / availableHeight,
        initialPage: _colorCodeIndex,
      );
    } else {
      _pageController = PageController(
        viewportFraction: 1,
        initialPage: _colorCodeIndex,
      );
    }
  }

  void _onUserScroll() {
    final pageIndex = _pageController.page?.floor() ?? 0;
    final hexColorCode = widget.colors[pageIndex].toHex();
    widget.colorCodeNotifier.value = ColorCode(
      hexColorCode: hexColorCode,
      source: ColorCodeSelectionSource.fromScroll,
    );
  }
}
