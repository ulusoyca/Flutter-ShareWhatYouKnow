import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_colors.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_shapes.dart';
import 'package:ulusoyapps_flutter/resources/themes/theme_view_model.dart';

extension BuildContextExtension on BuildContext {
  CompanyColors get appColors => this.watch<ThemeViewModel>().companyColors;
  TextTheme get baseTextTheme => this.watch<ThemeViewModel>().baseTextTheme;
  Brightness get brightness => this.watch<ThemeViewModel>().brightness;
  CompanyShapes get companyShapes => this.watch<ThemeViewModel>().companyShapes;
  bool get isDark => brightness == Brightness.dark;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  Size get screenSize => MediaQuery.of(this).size;
}
