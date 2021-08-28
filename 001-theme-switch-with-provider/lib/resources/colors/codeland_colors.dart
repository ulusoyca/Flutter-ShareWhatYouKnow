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
import 'package:theme_switch_with_provider/resources/colors/company_colors.dart';

import 'app_colors.dart';

class CodelandColors extends CompanyColors {
  CodelandColors(Brightness currentBrightness) : super(currentBrightness);

  @override
  final HeatmapColors heatmapColors = HeatmapColors(
    start: HSVColor.fromColor(AppColors.slateGrey.shade50),
    end: HSVColor.fromColor(AppColors.slateGrey.shade900),
  );

  @override
  final darkColorScheme = ColorScheme.dark(
    primary: AppColors.slateGrey.shade200,
    primaryVariant: AppColors.slateGrey[700]!,
    secondary: AppColors.orangeRed.shade200,
    secondaryVariant: AppColors.orangeRed[700]!,
    onPrimary: AppColors.black,
    onSecondary: AppColors.black,
    onBackground: AppColors.slateGrey[50]!,
    onSurface: AppColors.slateGrey[50]!,
  );

  @override
  final lightColorScheme = ColorScheme.light(
    primary: AppColors.slateGrey.shade500,
    primaryVariant: AppColors.slateGrey[700]!,
    secondary: AppColors.orangeRed.shade400,
    secondaryVariant: AppColors.orangeRed[700]!,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    background: AppColors.slateGrey[50]!,
    surface: AppColors.slateGrey[100]!,
    onBackground: AppColors.slateGrey[900]!,
    onSurface: AppColors.slateGrey[900]!,
  );
}
