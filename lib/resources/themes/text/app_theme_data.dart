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
import 'package:ulusoyapps_flutter/resources/colors/app_colors.dart';

import 'app_text_theme.dart';

class AppThemeData {
  static ThemeData buildThemeData({
    Brightness brightness,
    AppColors appColors,
    AppTextTheme appTextTheme,
  }) {
    final _colorScheme = appColors.colorScheme;

    /// Button Theme
    final buttonThemeData = ButtonThemeData(
      shape: StadiumBorder(),
      height: 45,
      colorScheme: _colorScheme,
      textTheme: ButtonTextTheme.primary,
    );

    /// Card Theme
    final cardTheme = CardTheme(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: _colorScheme.background),
      ),
      color: appColors.fillColor,
      shadowColor: appColors.boxShadowColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4.0, // this field changes the shadow of the card
    );

    /// Divider Theme
    final dividerThemeData = DividerThemeData(
      color: appColors.dividerColor,
      thickness: 1,
    );

    /// App bar
    final appBarThemeData = AppBarTheme(
      color: appColors.colorScheme.onPrimary,
      shadowColor: appColors.boxShadowColor,
      textTheme: appTextTheme.baseTextTheme,
    );

    /// Snackbar
    final snackbarThemeData = SnackBarThemeData(
      backgroundColor: appColors.snackbarBackground,
      contentTextStyle: appTextTheme.baseTextTheme.bodyText2.copyWith(color: appColors.colorScheme.onPrimary),
    );

    return ThemeData(
      primaryColor: _colorScheme.primary,
      accentColor: _colorScheme.secondary,
      buttonColor: _colorScheme.primary,
      textSelectionColor: _colorScheme.primary,
      colorScheme: _colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: appColors.colorScheme.background,
      cardColor: appColors.fillColor,
      dividerTheme: dividerThemeData,
      textTheme: appTextTheme.baseTextTheme,
      primaryTextTheme: appTextTheme.primaryTextTheme,
      accentTextTheme: appTextTheme.secondaryTextTheme,
      buttonTheme: buttonThemeData,
      cardTheme: cardTheme,
      appBarTheme: appBarThemeData,
      brightness: brightness,
      backgroundColor: _colorScheme.background,
      primaryColorLight: appColors.primaryLight,
      primaryColorDark: appColors.colorScheme.primaryVariant,
      snackBarTheme: snackbarThemeData,
    );
  }
}
