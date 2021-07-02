import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_code.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/shaped_button.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapeBorderListView extends StatelessWidget {
  final ValueNotifier<ShapeBorderType> shapeBorderTypeNotifier;
  final ValueNotifier<ColorCode> colorCodeNotifier;
  final MaterialColor sectionColor;

  const ShapeBorderListView({
    Key key,
    @required this.sectionColor,
    @required this.shapeBorderTypeNotifier,
    @required this.colorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (int i = 0; i < ShapeBorderType.values.length; i++)
          ShapedButton(
            shapeBorderType: ShapeBorderType.values[i],
            color: sectionColor,
            onPressed: () {
              colorCodeNotifier.value = ColorCode(
                hexColorCode: sectionColor.toHex(),
                source: ColorCodeSelectionSource.fromButtonClick,
              );
              shapeBorderTypeNotifier.value = ShapeBorderType.values[i];
            },
          ),
      ],
    );
  }
}
