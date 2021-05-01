import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class MyAppConfiguration {
  final String selectedColorCode;
  final ShapeBorderType shapeBorderType;
  final bool unknown;

  MyAppConfiguration.home({String selectedColorCode, String colorCodeFromBrowserHistory})
      : unknown = false,
        shapeBorderType = null,
        selectedColorCode = selectedColorCode;

  MyAppConfiguration.shapeBorder(String colorCode, ShapeBorderType shape)
      : unknown = false,
        shapeBorderType = shape,
        selectedColorCode = colorCode;

  MyAppConfiguration.unknown()
      : unknown = true,
        shapeBorderType = null,
        selectedColorCode = null;

  bool get isUnknown => unknown == true;
  bool get isHomePage => unknown == false && shapeBorderType == null;
  bool get isShapePage => unknown == false && selectedColorCode != null && shapeBorderType != null;
}
