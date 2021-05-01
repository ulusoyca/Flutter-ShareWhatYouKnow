import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class SinglePageAppConfiguration {
  final String selectedColorCode;
  final ShapeBorderType shapeBorderType;
  final bool unknown;
  final double scrollPosition;

  SinglePageAppConfiguration.home({String selectedColorCode, double scrollPosition})
      : unknown = false,
        shapeBorderType = null,
        scrollPosition = scrollPosition,
        selectedColorCode = selectedColorCode;

  SinglePageAppConfiguration.shapeBorder(String colorCode, ShapeBorderType shape)
      : unknown = false,
        scrollPosition = 0.0,
        shapeBorderType = shape,
        selectedColorCode = colorCode;

  SinglePageAppConfiguration.unknown()
      : unknown = true,
        scrollPosition = 0.0,
        shapeBorderType = null,
        selectedColorCode = null;

  bool get isUnknown => unknown == true;

  bool get isHomePage => unknown == false && shapeBorderType == null;

  bool get isShapePage => unknown == false && selectedColorCode != null && shapeBorderType != null;
}
