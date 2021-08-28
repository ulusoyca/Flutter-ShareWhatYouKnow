import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:single_page_scrollable_website/003-03-ensure-visible/shape_border_listview_03.dart';
import 'package:single_page_scrollable_website/entity/color_code.dart';
import 'package:single_page_scrollable_website/widgets/color_section_title.dart';
import 'package:single_page_scrollable_website/widgets/lorem_text.dart';

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
  final ScrollController _scrollController = ScrollController();
  late List<GlobalKey> keys;

  int get _colorCodeIndex {
    int index = widget.colors.indexWhere((element) {
      final hexColorCode = widget.colorCodeNotifier.value?.hexColorCode;
      return element.toHex() == hexColorCode;
    });
    return index > -1 ? index : 0;
  }

  @override
  void initState() {
    super.initState();
    keys = [for (int i = 0; i < widget.colors.length; i++) GlobalKey()];
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollToColor();
      widget.colorCodeNotifier.addListener(() {
        final fromScroll =
            widget.colorCodeNotifier.value?.source == ColorCodeSelectionSource.fromScroll;
        if (_scrollController.hasClients && !fromScroll) {
          _scrollToColor();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          _onUserScrolled(notification.metrics.pixels);
        }
        return true;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
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
            colorCodeNotifier: widget.colorCodeNotifier,
            shapeBorderTypeNotifier: widget.shapeBorderTypeNotifier,
          ),
          LoremText(seed: index),
        ],
      ),
    );
  }

  void _onUserScrolled(double offset) {
    double totalItemHeight = 0;
    for (int i = 0; i < keys.length; i++) {
      totalItemHeight += keys[i].currentContext!.size!.height;
      if (totalItemHeight > offset) {
        final color = widget.colors[i];
        widget.colorCodeNotifier.value = ColorCode(
          hexColorCode: color.toHex(),
          source: ColorCodeSelectionSource.fromScroll,
        );
        break;
      }
    }
  }

  void _scrollToColor() {
    Scrollable.ensureVisible(
      keys[_colorCodeIndex].currentContext!,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
