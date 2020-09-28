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

class AppColors {
  /// Base Colors
  static const Color _white = Colors.white;
  static const Color _black = Colors.black;
  static const Color _red = Color(0xFFFF0000);
  static const Color _rose = Color(0xFFFF6363);
  static const Color _green = Color(0xFF59DD00);
  static const Color _brightSun = Color(0xFFFCC94A);
  static const Color _balticSea = Color(0xFF18171d); // 900
  static const Color _raisinBlack = Color(0xFF242329); // 900
  static const Color _onyx = Color(0xFF45444B); // 900
  static const Color _alabaster = Color(0xFFFAFAFA);
  static const Color _abbey = Color(0xFF464648);
  static const Color _dimGray = Color(0xFF666666);
  static const Color _shadow = Color.fromRGBO(33, 22, 156, 0.1);
  static const Color _whisper = Color(0xFFECECF4);

  static const Color _lavenderBlue = Color(0xFFdbcff5); // 100
  static const Color _maximumBluePurple = Color(0xFFC4AFF0); // 200
  static const Color _mediumSlateBluePurple = Color(0xFF8459dc); // 500
  static const Color _oceanBlue = Color(0xFF532dc5); // 900

  static const Color _celeste = Color(0xFFAEF0ED); // 100
  static const Color _electricBlue = Color(0xFF76E5E3); // 200
  static const Color _darkTurquoise = Color(0xFF00C9D1); // 500
  static const Color _pineGreen = Color(0xFF00a1a3); // 900

  final Color primaryLight;
  final Color secondaryLight;
  final Color dividerColor;
  final Color snackbarBackground;
  final Color boxShadowColor;
  final Color fillColor;
  final ColorScheme colorScheme;
  final GraphColors graphColors;
  final AlertLevels alertLevels;
  final TrendLevelColors trendLevels;

  AppColors({
    this.primaryLight,
    this.secondaryLight,
    this.dividerColor,
    this.snackbarBackground,
    this.colorScheme,
    this.boxShadowColor,
    this.fillColor,
    this.graphColors,
    this.alertLevels,
    this.trendLevels,
  });

  static AppColors buildAppColors(bool isDarkThemeOn) => isDarkThemeOn ? _buildDarkAppColors() : _buildLightAppColors();

  static AppColors _buildLightAppColors() => AppColors(
        primaryLight: AppColors._lavenderBlue,
        secondaryLight: AppColors._celeste,
        dividerColor: AppColors._shadow,
        snackbarBackground: _dimGray,
        fillColor: AppColors._white,
        boxShadowColor: AppColors._shadow,
        colorScheme: ColorScheme(
          primary: AppColors._mediumSlateBluePurple,
          primaryVariant: AppColors._oceanBlue,
          secondary: AppColors._darkTurquoise,
          secondaryVariant: AppColors._pineGreen,
          background: AppColors._alabaster,
          surface: AppColors._white,
          onBackground: AppColors._white,
          onSurface: AppColors._black,
          error: AppColors._red,
          onError: AppColors._white,
          onPrimary: AppColors._white,
          onSecondary: AppColors._white,
          brightness: Brightness.light,
        ),
        graphColors: GraphColors(
          primaryColor: AppColors._mediumSlateBluePurple,
          secondaryColor: AppColors._darkTurquoise,
          targetFillColor: Colors.grey.shade700,
          backgroundColor: AppColors._whisper,
          belowTarget: AppColors._rose,
          onTarget: AppColors._brightSun,
          aboveTarget: AppColors._green,
        ),
        alertLevels: AlertLevels(
          alert: AppColors._red,
          warning: AppColors._brightSun,
          neutral: Colors.grey.shade500,
          safe: AppColors._green,
        ),
        trendLevels: TrendLevelColors(
          increasing: AppColors._green,
          decreasing: AppColors._red,
          unchanged: Colors.grey.shade500,
        ),
      );

  static AppColors _buildDarkAppColors() => AppColors(
        primaryLight: AppColors._lavenderBlue,
        secondaryLight: AppColors._celeste,
        dividerColor: AppColors._onyx,
        snackbarBackground: _alabaster,
        fillColor: AppColors._raisinBlack,
        boxShadowColor: Colors.transparent,
        colorScheme: ColorScheme(
          primary: AppColors._maximumBluePurple,
          primaryVariant: AppColors._oceanBlue,
          secondary: AppColors._electricBlue,
          secondaryVariant: AppColors._pineGreen,
          background: AppColors._balticSea,
          surface: AppColors._raisinBlack,
          onBackground: AppColors._alabaster,
          onSurface: AppColors._alabaster,
          error: AppColors._rose,
          onError: AppColors._alabaster,
          onPrimary: AppColors._black,
          onSecondary: AppColors._white,
          brightness: Brightness.dark,
        ),
        graphColors: GraphColors(
          primaryColor: AppColors._maximumBluePurple,
          secondaryColor: AppColors._electricBlue,
          targetFillColor: AppColors._white,
          backgroundColor: AppColors._abbey,
          belowTarget: AppColors._rose,
          onTarget: AppColors._brightSun,
          aboveTarget: AppColors._green,
        ),
        alertLevels: AlertLevels(
          alert: AppColors._red,
          warning: AppColors._brightSun,
          neutral: Colors.grey.shade500,
          safe: AppColors._green,
        ),
        trendLevels: TrendLevelColors(
          increasing: AppColors._green,
          decreasing: AppColors._red,
          unchanged: Colors.grey.shade500,
        ),
      );
}

class GraphColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color targetFillColor;
  final Color aboveTarget;
  final Color onTarget;
  final Color belowTarget;

  GraphColors({
    this.primaryColor,
    this.secondaryColor,
    this.backgroundColor,
    this.targetFillColor,
    this.aboveTarget,
    this.onTarget,
    this.belowTarget,
  });
}

class AlertLevels {
  final Color safe;
  final Color alert;
  final Color warning;
  final Color neutral;

  AlertLevels({
    this.safe,
    this.alert,
    this.warning,
    this.neutral,
  });
}

class TrendLevelColors {
  final Color increasing;
  final Color decreasing;
  final Color unchanged;

  TrendLevelColors({
    this.increasing,
    this.decreasing,
    this.unchanged,
  });
}
