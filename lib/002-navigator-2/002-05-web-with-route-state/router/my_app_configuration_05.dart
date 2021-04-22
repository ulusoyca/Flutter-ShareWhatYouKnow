import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class MyAppConfiguration {
  final String selectedColorCode;
  final ShapeBorderType shapeBorderType;
  final bool unknown;
  final String colorCodeFromBrowserHistory;

  MyAppConfiguration.home({String selectedColorCode, String colorCodeFromBrowserHistory})
      : unknown = false,
        shapeBorderType = null,
        colorCodeFromBrowserHistory = colorCodeFromBrowserHistory,
        selectedColorCode = selectedColorCode;

  MyAppConfiguration.shapeBorder(String colorCode, ShapeBorderType shape)
      : unknown = false,
        shapeBorderType = shape,
        colorCodeFromBrowserHistory = null,
        selectedColorCode = colorCode;

  MyAppConfiguration.unknown()
      : unknown = true,
        shapeBorderType = null,
        colorCodeFromBrowserHistory = null,
        selectedColorCode = null;

  bool get isUnknown => unknown == true;
  bool get isHomePage => unknown == false && shapeBorderType == null;
  bool get isShapePage => unknown == false && selectedColorCode != null && shapeBorderType != null;
}
