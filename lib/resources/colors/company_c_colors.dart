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

import 'app_colors.dart';

class CompanyColorsC extends CompanyColors {
  CompanyColorsC(Brightness currentBrightness) : super(currentBrightness);

  final List<Color> lightSupplementaryColors = [
    AppColors.keppel,
    AppColors.tomato,
    AppColors.capri,
    AppColors.winterSky,
    AppColors.plumpPurple,
  ];

  final List<Color> darkSupplementaryColors = [
    AppColors.aquamarine,
    AppColors.vividTangerine,
    AppColors.mayaBlue,
    AppColors.persianPink,
    AppColors.lavender,
  ];

  @override
  final HeatmapColors heatmapColors = HeatmapColors(
    start: HSVColor.fromColor(AppColors.vividTangerine),
    end: HSVColor.fromColor(AppColors.darkLiverHorses),
  );

  @override
  final darkColorScheme = ColorScheme(
    primary: AppColors.beauBlue,
    primaryVariant: AppColors.charcoal,
    secondary: AppColors.vividTangerine,
    secondaryVariant: AppColors.darkLiverHorses,
    background: AppColors.balticSea,
    surface: AppColors.darkGrey,
    onBackground: AppColors.alabaster,
    onSurface: AppColors.alabaster,
    error: AppColors.rose,
    onError: AppColors.alabaster,
    onPrimary: AppColors.black,
    onSecondary: AppColors.black,
    brightness: Brightness.dark,
  );

  @override
  final lightColorScheme = ColorScheme(
    primary: AppColors.slateGray,
    primaryVariant: AppColors.charcoal,
    secondary: AppColors.orangeRed,
    secondaryVariant: AppColors.darkLiverHorses,
    background: AppColors.alabaster,
    surface: AppColors.white,
    onBackground: AppColors.white,
    onSurface: AppColors.black,
    error: AppColors.rose,
    onError: AppColors.white,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    brightness: Brightness.light,
  );
}
