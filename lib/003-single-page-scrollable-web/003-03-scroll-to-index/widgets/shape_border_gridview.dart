import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shaped_container.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';

class ShapeBorderGridView extends StatelessWidget {
  final ValueNotifier<ShapeBorderType> selectedShapeBorderType;
  final ValueNotifier<String> selectedColorCode;
  final Color sectionColor;

  const ShapeBorderGridView({
    Key key,
    @required this.sectionColor,
    @required this.selectedColorCode,
    @required this.selectedShapeBorderType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShapeBorderType> shapeBorders = ShapeBorderType.values;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: GridView.builder(
          itemCount: shapeBorders.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final shapeBorderType = shapeBorders[index];
            return ShapedButton(
              shapeBorderType: shapeBorderType,
              color: sectionColor,
              onPressed: () {
                selectedColorCode.value = sectionColor.toHex(leadingHashSign: false);
                selectedShapeBorderType.value = shapeBorderType;
              },
            );
          },
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 4,
            mainAxisExtent: 120,
          ),
        ),
      ),
    );
  }
}
