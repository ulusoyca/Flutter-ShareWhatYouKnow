import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shaped_container.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';

class ShapeBorderGridView extends StatelessWidget {
  final Function(ShapeBorderType) onShapeTap;
  final Color color;

  const ShapeBorderGridView({
    Key key,
    @required this.color,
    @required this.onShapeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShapeBorderType> shapeBorders = ShapeBorderType.values;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: GridView.builder(
          itemCount: shapeBorders.length,
          itemBuilder: (BuildContext context, int index) {
            final shapeBorderType = shapeBorders[index];
            return ShapedButton(
              shapeBorderType: shapeBorderType,
              color: color,
              onPressed: () {
                onShapeTap(shapeBorderType);
              },
            );
          },
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            crossAxisSpacing: AppDimens.SIZE_SPACING_MEDIUM,
            mainAxisSpacing: AppDimens.SIZE_SPACING_MEDIUM,
            childAspectRatio: 3,
          ),
        ),
      ),
    );
  }
}
