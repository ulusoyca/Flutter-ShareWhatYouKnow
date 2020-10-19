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
import 'package:ulusoyapps_flutter/resources/colors/company_a_colors.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_b_colors.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_c_colors.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_colors.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_a_shapes.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_b_shapes.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_c_shapes.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_shapes.dart';
import 'package:ulusoyapps_flutter/resources/themes/text/company_a_text_theme.dart';
import 'package:ulusoyapps_flutter/resources/themes/text/company_b_text_theme.dart';
import 'package:ulusoyapps_flutter/resources/themes/text/company_c_text_theme.dart';
import 'package:ulusoyapps_flutter/resources/themes/text/company_text_theme.dart';

import 'companies.dart';
import 'company_a_theme_data.dart';
import 'company_b_theme_data.dart';
import 'company_c_theme_data.dart';

abstract class CompanyThemeData {
  FloatingActionButtonThemeData fabTheme;
  BottomAppBarTheme bottomAppBarTheme;
  final Brightness brightness;
  final CompanyColors colors;
  final CompanyTextTheme textTheme;
  final CompanyShapes shapes;
  final Company company;

  factory CompanyThemeData.companyA(brightness) {
    final colors = CompanyColorsA(brightness);
    return CompanyThemeDataA(
      Company.COMPANY_A,
      brightness,
      colors,
      CompanyTextThemeA(
        colors.colorScheme.onSurface,
        colors.colorScheme.onSurface,
        colors.colorScheme.onPrimary,
        colors.colorScheme.onPrimary,
      ),
      CompanyShapesA(),
    );
  }

  factory CompanyThemeData.companyB(brightness) {
    final colors = CompanyColorsB(brightness);
    return CompanyThemeDataB(
      Company.COMPANY_B,
      brightness,
      colors,
      CompanyTextThemeB(
        colors.colorScheme.onSurface,
        colors.colorScheme.onSurface,
        colors.colorScheme.onPrimary,
        colors.colorScheme.onPrimary,
      ),
      CompanyShapesB(),
    );
  }

  factory CompanyThemeData.companyC(brightness) {
    final colors = CompanyColorsC(brightness);
    return CompanyThemeDataC(
      Company.COMPANY_C,
      brightness,
      colors,
      CompanyTextThemeC(
        colors.colorScheme.onSurface,
        colors.colorScheme.onSurface,
        colors.colorScheme.onPrimary,
        colors.colorScheme.onPrimary,
      ),
      CompanyShapesC(),
    );
  }

  CompanyThemeData(
    this.company,
    this.brightness,
    this.colors,
    this.textTheme,
    this.shapes,
  );

  ThemeData get themeData {
    final _colorScheme = colors.colorScheme;

    /// Button Theme
    final buttonThemeData = ButtonThemeData(
      height: 45,
      colorScheme: _colorScheme,
      textTheme: ButtonTextTheme.primary,
      shape: shapes.buttonShapeBorder,
    );

    /// Card Theme
    final cardTheme = CardTheme(
      shadowColor: colors.shadowColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      // this field changes the shadow of the card
      shape: shapes.cardShapeBorder,
    );

    /// Divider Theme
    final dividerThemeData = DividerThemeData(
      color: colors.dividerColor,
      thickness: 1,
    );

    final primaryIconTheme = IconThemeData(
      color: _colorScheme.onPrimary,
    );

    final toggleButtonsTheme = ToggleButtonsThemeData(
      borderWidth: 0.0,
    );

    final chipThemeData = ChipThemeData(
      backgroundColor: _colorScheme.background,
      disabledColor: _colorScheme.background,
      selectedColor: _colorScheme.background,
      secondarySelectedColor: _colorScheme.background,
      padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_SMALL, vertical: AppDimens.SIZE_SPACING_XS),
      shape: shapes.chipShapeBorder,
      labelStyle: textTheme.baseTextTheme.caption,
      secondaryLabelStyle: textTheme.secondaryTextTheme.caption,
      brightness: brightness,
    );

    return ThemeData(
      primaryColor: _colorScheme.primary,
      accentColor: Colors.red[500],
      buttonColor: _colorScheme.primary,
      textSelectionColor: _colorScheme.primary,
      colorScheme: _colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: colors.colorScheme.background,
      dividerTheme: dividerThemeData,
      textTheme: textTheme.baseTextTheme,
      primaryTextTheme: textTheme.primaryTextTheme,
      accentTextTheme: textTheme.secondaryTextTheme,
      buttonTheme: buttonThemeData,
      cardTheme: cardTheme,
      brightness: brightness,
      backgroundColor: _colorScheme.background,
      toggleButtonsTheme: toggleButtonsTheme,
      floatingActionButtonTheme: fabTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      primaryIconTheme: primaryIconTheme,
      applyElevationOverlayColor: true,
      chipTheme: chipThemeData,
    );
  }
}
