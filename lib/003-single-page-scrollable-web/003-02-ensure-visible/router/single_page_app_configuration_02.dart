import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class SinglePageAppConfiguration {
  final String colorCode;
  final ShapeBorderType shapeBorderType;
  final bool unknown;

  SinglePageAppConfiguration.home({String selectedColorCode})
      : unknown = false,
        shapeBorderType = null,
        colorCode = selectedColorCode;

  SinglePageAppConfiguration.shapeBorder(String colorCode, ShapeBorderType shape)
      : unknown = false,
        shapeBorderType = shape,
        colorCode = colorCode;

  SinglePageAppConfiguration.unknown()
      : unknown = true,
        shapeBorderType = null,
        colorCode = null;

  bool get isUnknown => unknown == true;

  bool get isHomePage => unknown == false && shapeBorderType == null;

  bool get isShapePage => unknown == false && colorCode != null && shapeBorderType != null;
}
