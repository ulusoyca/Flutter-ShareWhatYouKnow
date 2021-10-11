import 'package:common/dimens/app_dimens.dart';
import 'package:common/extensions/color_extensions.dart';
import 'package:common/widgets/colored_text.dart';
import 'package:flutter/material.dart';

class ColorGrid extends StatelessWidget {
  final List<Color> colors;
  final Function(String) onColorTap;

  const ColorGrid({
    Key? key,
    required this.colors,
    required this.onColorTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        var color = colors[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                onColorTap(color.toHex());
              },
              style: ElevatedButton.styleFrom(primary: color),
              child: ColoredText(color: color),
            ),
          ),
        );
      },
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: AppDimens.SIZE_SPACING_MEDIUM,
        mainAxisSpacing: AppDimens.SIZE_SPACING_MEDIUM,
        childAspectRatio: 3,
      ),
    );
  }
}
