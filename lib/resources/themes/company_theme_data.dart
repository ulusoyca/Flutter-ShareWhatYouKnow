/*
 * Copyright 2020 Cagatay Ulusoy (Ulus Oy Apps). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_colors.dart';
import 'package:ulusoyapps_flutter/resources/themes/text/company_text_theme.dart';

abstract class CompanyThemeData {
  ShapeBorder materialShapeBorder;
  ShapeBorder barGraphShapeBorder;
  double borderRadiusValue;
  BorderRadius borderRadius;
  FloatingActionButtonThemeData fabTheme;
  ToggleButtonsThemeData toggleButtonsThemeData;
  BottomAppBarTheme bottomAppBarTheme;
  final Brightness brightness;
  final CompanyColors companyColors;
  final CompanyTextTheme companyTextTheme;

  CompanyThemeData(
    this.brightness,
    this.companyColors,
    this.companyTextTheme,
  );

  ThemeData buildThemeData() {
    final _colorScheme = companyColors.colorScheme;

    /// Button Theme
    final buttonThemeData = ButtonThemeData(
      height: 45,
      colorScheme: _colorScheme,
      textTheme: ButtonTextTheme.primary,
      shape: materialShapeBorder,
    );

    /// Card Theme
    final cardTheme = CardTheme(
      shadowColor: companyColors.shadowColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      // this field changes the shadow of the card
      shape: materialShapeBorder,
    );

    /// Divider Theme
    final dividerThemeData = DividerThemeData(
      color: companyColors.dividerColor,
      thickness: 1,
    );

    /// Snackbar
    final snackbarThemeData = SnackBarThemeData(
      backgroundColor: companyColors.colorScheme.surface,
      contentTextStyle: companyTextTheme.baseTextTheme.bodyText2.copyWith(color: companyColors.colorScheme.onPrimary),
    );

    final primaryIconTheme = IconThemeData(
      color: _colorScheme.onPrimary,
    );

    return ThemeData(
      primaryColor: _colorScheme.primary,
      buttonColor: _colorScheme.primary,
      textSelectionColor: _colorScheme.primary,
      colorScheme: _colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: companyColors.colorScheme.background,
      dividerTheme: dividerThemeData,
      textTheme: companyTextTheme.baseTextTheme,
      primaryTextTheme: companyTextTheme.primaryTextTheme,
      accentTextTheme: companyTextTheme.secondaryTextTheme,
      buttonTheme: buttonThemeData,
      cardTheme: cardTheme,
      brightness: brightness,
      backgroundColor: _colorScheme.background,
      snackBarTheme: snackbarThemeData,
      toggleButtonsTheme: toggleButtonsThemeData,
      floatingActionButtonTheme: fabTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      primaryIconTheme: primaryIconTheme,
      applyElevationOverlayColor: true,
    );
  }
}
