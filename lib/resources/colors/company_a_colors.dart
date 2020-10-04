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

class CompanyColorsA extends CompanyColors {
  CompanyColorsA(Brightness currentBrightness) : super(currentBrightness);

  @override
  final darkColorScheme = ColorScheme(
    primary: AppColors.maximumBluePurple,
    primaryVariant: AppColors.oceanBlue,
    secondary: AppColors.electricBlue,
    secondaryVariant: AppColors.pineGreen,
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
    primary: AppColors.mediumSlateBluePurple,
    primaryVariant: AppColors.oceanBlue,
    secondary: AppColors.darkTurquoise,
    secondaryVariant: AppColors.pineGreen,
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
