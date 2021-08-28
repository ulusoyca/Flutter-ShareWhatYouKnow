import 'package:common/dimens/app_dimens.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:flutter/material.dart';
import 'package:navigator_2/widgets/shaped_button.dart';

class ShapeBorderGridView extends StatelessWidget {
  final Function(ShapeBorderType) onShapeTap;
  final ScrollPhysics scrollPhysics;
  final Color color;
  final SliverGridDelegate sliverGridDelegate;

  const ShapeBorderGridView({
    Key? key,
    required this.color,
    required this.onShapeTap,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.sliverGridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 400,
      crossAxisSpacing: AppDimens.SIZE_SPACING_MEDIUM,
      mainAxisSpacing: AppDimens.SIZE_SPACING_MEDIUM,
      childAspectRatio: 3,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShapeBorderType> shapeBorders = ShapeBorderType.values;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: GridView.builder(
          itemCount: shapeBorders.length,
          physics: scrollPhysics,
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
          gridDelegate: sliverGridDelegate,
        ),
      ),
    );
  }
}
