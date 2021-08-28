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

class AtaColors extends CompanyColors {
  AtaColors(Brightness currentBrightness) : super(currentBrightness);

  @override
  final HeatmapColors heatmapColors = HeatmapColors(
    start: HSVColor.fromColor(AppColors.bluePurple.shade50),
    end: HSVColor.fromColor(AppColors.bluePurple..shade900),
  );

  @override
  final darkColorScheme = ColorScheme.dark(
    primary: AppColors.bluePurple.shade200,
    primaryVariant: AppColors.bluePurple[700]!,
    secondary: AppColors.turquoise.shade200,
    secondaryVariant: AppColors.turquoise[700]!,
    onPrimary: AppColors.black,
    onSecondary: AppColors.black,
  );

  @override
  final lightColorScheme = ColorScheme.light(
    primary: AppColors.bluePurple.shade500,
    primaryVariant: AppColors.bluePurple[700]!,
    background: AppColors.bluePurple[50]!,
    onBackground: AppColors.bluePurple[900]!,
    secondary: AppColors.turquoise.shade400,
    secondaryVariant: AppColors.turquoise[700]!,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
  );
}
