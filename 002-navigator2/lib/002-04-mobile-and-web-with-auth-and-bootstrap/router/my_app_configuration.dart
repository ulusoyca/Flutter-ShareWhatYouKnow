import 'package:common/model/shape_border_type.dart';

class MyAppConfiguration {
  final String? colorCode;
  final ShapeBorderType? shapeBorderType;
  final bool unknown;
  final bool? loggedIn;

  MyAppConfiguration.splash()
      : unknown = false,
        loggedIn = null,
        shapeBorderType = null,
        colorCode = null;

  MyAppConfiguration.login()
      : unknown = false,
        loggedIn = false,
        shapeBorderType = null,
        colorCode = null;

  MyAppConfiguration.shapeBorder(String? colorCode, ShapeBorderType? shape)
      : unknown = false,
        shapeBorderType = shape,
        loggedIn = true,
        colorCode = colorCode;

  MyAppConfiguration.color(String? colorCode)
      : unknown = false,
        shapeBorderType = null,
        loggedIn = true,
        colorCode = colorCode;

  MyAppConfiguration.home()
      : unknown = false,
        shapeBorderType = null,
        loggedIn = true,
        colorCode = null;

  MyAppConfiguration.unknown()
      : unknown = true,
        shapeBorderType = null,
        loggedIn = null,
        colorCode = null;

  bool get isUnknown => unknown == true;
  bool get isHomePage =>
      unknown == false && loggedIn == true && colorCode == null && shapeBorderType == null;
  bool get isColorPage =>
      unknown == false && loggedIn == true && colorCode != null && shapeBorderType == null;
  bool get isShapePage =>
      unknown == false && loggedIn == true && colorCode != null && shapeBorderType != null;
  bool get isLoginPage => unknown == false && loggedIn == false;
  bool get isSplashPage => unknown == false && loggedIn == null;
}
