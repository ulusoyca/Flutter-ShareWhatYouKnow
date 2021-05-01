import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/colored_text.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';

class ColorGrid extends StatelessWidget {
  final List<Color> colors;
  final ValueNotifier<String> selectedColorCode;

  const ColorGrid({
    Key key,
    this.colors,
    this.selectedColorCode,
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
                selectedColorCode.value = color.toHex();
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
