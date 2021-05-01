import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shaped_container.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapeBorderListView extends StatelessWidget {
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<String> selectedColorCodeNotifier;
  final MaterialColor sectionColor;

  const ShapeBorderListView({
    Key key,
    @required this.sectionColor,
    @required this.selectedShapeBorderTypeNotifier,
    @required this.selectedColorCodeNotifier,
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
              selectedColorCodeNotifier.value = sectionColor.toHex();
              selectedShapeBorderTypeNotifier.value = ShapeBorderType.values[i];
            },
          ),
      ],
    );
  }
}
