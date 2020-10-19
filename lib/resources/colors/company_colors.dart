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

import 'app_colors.dart';

abstract class CompanyColors {
  final Brightness currentBrightness;

  CompanyColors(this.currentBrightness);

  ColorScheme get colorScheme => isDark() ? darkColorScheme : lightColorScheme;

  final List<MaterialAccentColor> supplementaryAccentColors = [
    AppColors.veroneseGreen,
    AppColors.tomato,
    AppColors.vividSky,
    AppColors.champagne,
    AppColors.mauve,
  ];

  List<Color> get _supplementaryLightColors => supplementaryAccentColors.map((e) => e.shade400).toList();
  List<Color> get _supplementaryDarkColors => supplementaryAccentColors.map((e) => e.shade200).toList();
  List<Color> get supplementaryColors => isDark() ? _supplementaryDarkColors : _supplementaryLightColors;

  HeatmapColors heatmapColors;

  Color get dividerColor => isDark() ? AppColors.onyx : AppColors.shadow;
  Color get shadowColor => isDark() ? AppColors.transparent : AppColors.shadow;

  final graphColors = GraphColors(
    backgroundColor: AppColors.balticSea,
    belowTarget: AppColors.rose,
    onTarget: AppColors.brightSun,
    aboveTarget: AppColors.green,
  );

  final alertLevels = AlertLevels(
    alert: AppColors.red,
    warning: AppColors.brightSun,
    neutral: Colors.grey.shade500,
    safe: AppColors.green,
  );

  final trendLevels = TrendLevelColors(
    increasing: AppColors.green,
    decreasing: AppColors.red,
    unchanged: Colors.grey.shade500,
  );

  ColorScheme darkColorScheme;
  ColorScheme lightColorScheme;

  bool isDark() => currentBrightness == Brightness.dark;
}

class GraphColors {
  final Color backgroundColor;
  final Color aboveTarget;
  final Color onTarget;
  final Color belowTarget;

  GraphColors({
    this.backgroundColor,
    this.aboveTarget,
    this.onTarget,
    this.belowTarget,
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
