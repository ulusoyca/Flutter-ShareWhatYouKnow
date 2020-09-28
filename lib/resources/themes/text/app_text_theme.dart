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
import 'package:google_fonts/google_fonts.dart';
import 'package:ulusoyapps_flutter/resources/colors/app_colors.dart';

class AppTextTheme {
  TextTheme baseTextTheme;
  TextTheme primaryTextTheme;
  TextTheme secondaryTextTheme;
  Color displayColor;
  Color bodyColor;

  static const DEFAULT_LETTER_SPACING = 0.3;

  AppTextTheme({
    @required this.displayColor,
    @required this.bodyColor,
  }) {
    baseTextTheme = _buildBaseTextTheme();
    primaryTextTheme = _buildPrimaryTextTheme();
    // For now, primary and secondary text themes are the same
    secondaryTextTheme = _buildPrimaryTextTheme();
  }

  TextTheme _buildPrimaryTextTheme() => baseTextTheme.copyWith(
        button: baseTextTheme.caption.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: 14,
          letterSpacing: DEFAULT_LETTER_SPACING,
          color: displayColor,
        ),
      );

  TextTheme _buildBaseTextTheme() {
    final currentTextTheme = TextTheme(
      headline6: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      headline5: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline3: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        fontSize: 71,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline1: TextStyle(
        fontSize: 113,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      subtitle1: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        letterSpacing: DEFAULT_LETTER_SPACING,
      ),
      caption: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      overline: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ).apply(
      displayColor: displayColor,
      bodyColor: bodyColor,
    );
    return GoogleFonts.montserratTextTheme(currentTextTheme);
  }

  static AppTextTheme buildAppTextTheme({AppColors appColors}) => AppTextTheme(
        displayColor: appColors.colorScheme.onBackground,
        bodyColor: appColors.colorScheme.onSurface,
      );
}
