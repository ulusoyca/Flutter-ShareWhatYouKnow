import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shaped_container.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_code.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';

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
    List<ShapeBorderType> shapeBorders = ShapeBorderType.values;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0; i < shapeBorders.length; i++)
              ShapedButton(
                shapeBorderType: shapeBorders[i],
                color: sectionColor,
                onPressed: () {
                  colorCodeNotifier.value = ColorCode(
                    hexColorCode: sectionColor.toHex(),
                    source: ColorCodeSelectionSource.fromButtonClick,
                  );
                  shapeBorderTypeNotifier.value = shapeBorders[i];
                },
              )
          ],
        ),
      ),
    );
  }
}
