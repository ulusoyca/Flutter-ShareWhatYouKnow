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
import 'dart:ui';

import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';

abstract class CompanyThemeData {
  late ThemeData _themeData;
  late FloatingActionButtonThemeData fabTheme;
  ThemeData get themeData => _themeData;

  CompanyThemeData(colors, shapes, companyTextTheme, brightness) {
    ButtonThemeData buttonThemeData = ButtonThemeData(
      height: AppDimens.SIZE_SPACING_3XL,
      colorScheme: colors.colorScheme,
      textTheme: ButtonTextTheme.primary,
      shape: shapes.buttonShapeBorder,
    );
    CardTheme cardTheme = CardTheme(
      shadowColor: colors.shadowColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      shape: shapes.cardShapeBorder,
    );
    DividerThemeData dividerThemeData = DividerThemeData(
      color: colors.dividerColor,
      thickness: 1,
    );
    IconThemeData primaryIconTheme = IconThemeData(
      color: colors.colorScheme.onPrimary,
    );
    ToggleButtonsThemeData toggleButtonsTheme = ToggleButtonsThemeData(
      borderWidth: 0.0,
    );
    ChipThemeData chipThemeData = ChipThemeData(
      backgroundColor: colors.colorScheme.background,
      disabledColor: colors.colorScheme.background,
      selectedColor: colors.colorScheme.background,
      secondarySelectedColor: colors.colorScheme.background,
      padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_SPACING_SMALL, vertical: AppDimens.SIZE_SPACING_XS),
      shape: shapes.chipShapeBorder,
      labelStyle: companyTextTheme.baseTextTheme.caption,
      secondaryLabelStyle: companyTextTheme.secondaryTextTheme.caption,
      brightness: brightness,
    );
    BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme(
      shape: shapes.bottomAppBarShape,
      color: colors.colorScheme.primary,
    );

    _themeData = ThemeData(
      buttonColor: colors.colorScheme.primary,
      textSelectionColor: colors.colorScheme.primary,
      colorScheme: colors.colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: colors.colorScheme.background,
      dividerTheme: dividerThemeData,
      textTheme: companyTextTheme.baseTextTheme,
      primaryTextTheme: companyTextTheme.primaryTextTheme,
      accentTextTheme: companyTextTheme.secondaryTextTheme,
      buttonTheme: buttonThemeData,
      cardTheme: cardTheme,
      brightness: brightness,
      backgroundColor: colors.colorScheme.background,
      toggleButtonsTheme: toggleButtonsTheme,
      floatingActionButtonTheme: fabTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      primaryIconTheme: primaryIconTheme,
      applyElevationOverlayColor: true,
      chipTheme: chipThemeData,
    );
  }
}
