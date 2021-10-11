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
import 'company_colors.dart';

class BiohackColors extends CompanyColors {
  BiohackColors(Brightness currentBrightness) : super(currentBrightness);

  @override
  final HeatmapColors heatmapColors = HeatmapColors(
    start: HSVColor.fromColor(AppColors.capri.shade50),
    end: HSVColor.fromColor(AppColors.capri.shade900),
  );

  @override
  final darkColorScheme = ColorScheme.dark(
    primary: AppColors.capri.shade200,
    primaryVariant: AppColors.capri.shade900,
    secondary: AppColors.rose.shade200,
    secondaryVariant: AppColors.rose.shade700,
    background: AppColors.balticSea,
    surface: AppColors.darkGrey,
    onBackground: AppColors.alabaster,
    onSurface: AppColors.alabaster,
    onPrimary: AppColors.black,
    onSecondary: AppColors.black,
    brightness: Brightness.dark,
  );

  @override
  final lightColorScheme = ColorScheme.light(
    primary: AppColors.capri.shade500,
    primaryVariant: AppColors.capri.shade900,
    secondary: AppColors.rose.shade400,
    secondaryVariant: AppColors.rose.shade700,
    background: AppColors.alabaster,
    surface: AppColors.white,
    onBackground: AppColors.white,
    onSurface: AppColors.black,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    brightness: Brightness.light,
  );
}
