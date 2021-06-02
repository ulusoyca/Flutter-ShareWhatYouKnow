import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shaped_container.dart';
import 'package:ulusoyapps_flutter/entity/color_selection.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';

class ShapeBorderListView extends StatelessWidget {
  final ValueNotifier<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<ColorCodeSelection> selectedColorCodeNotifier;
  final MaterialColor sectionColor;

  const ShapeBorderListView({
    Key key,
    @required this.sectionColor,
    @required this.selectedShapeBorderTypeNotifier,
    @required this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShapeBorderType> shapeBorders = ShapeBorderType.values;
    return Padding(
      padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
      child: ListView.builder(
        itemCount: shapeBorders.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final shapeBorderType = shapeBorders[index];
          return ShapedButton(
              shapeBorderType: shapeBorderType,
              color: sectionColor,
              onPressed: () {
                selectedColorCodeNotifier.value =
                    ColorCodeSelection(hexColorCode: sectionColor.toHex(), fromScroll: false);
                selectedShapeBorderTypeNotifier.value = shapeBorderType;
              });
        },
      ),
    );
  }
}
