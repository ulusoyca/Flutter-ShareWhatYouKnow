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
import 'package:theme_switch_with_provider/resources/colors/company_colors.dart';
import 'package:theme_switch_with_provider/resources/themes/text/company_text_theme.dart';

class CodelandTextTheme extends CompanyTextTheme {
  CodelandTextTheme(CompanyColors colors) : super(colors);

  @override
  TextTheme buildPrimaryTextTheme(Color displayColor, Color bodyColor) => baseTextTheme
      .copyWith(
        button: baseTextTheme.caption!.copyWith(
          fontSize: 14,
          color: displayColor,
        ),
      )
      .apply(
        displayColor: displayColor,
        bodyColor: bodyColor,
      );

  @override
  TextTheme buildSecondaryTextTheme(Color displayColor, Color bodyColor) => baseTextTheme
      .copyWith(
        button: baseTextTheme.caption!.copyWith(
          fontSize: 14,
          color: displayColor,
        ),
      )
      .apply(
        displayColor: displayColor,
        bodyColor: bodyColor,
      );

  @override
  TextTheme buildBaseTextTheme(Color displayColor, Color bodyColor) {
    final currentTextTheme = TextTheme(
      headline1: GoogleFonts.sourceCodePro(
          fontSize: 105, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      headline2:
          GoogleFonts.sourceCodePro(fontSize: 66, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      headline3: GoogleFonts.sourceCodePro(fontSize: 52, fontWeight: FontWeight.w400),
      headline4:
          GoogleFonts.sourceCodePro(fontSize: 37, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5: GoogleFonts.sourceCodePro(fontSize: 26, fontWeight: FontWeight.w400),
      headline6:
          GoogleFonts.sourceCodePro(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      subtitle1:
          GoogleFonts.sourceCodePro(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      subtitle2:
          GoogleFonts.sourceCodePro(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyText1:
          GoogleFonts.sourceCodePro(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyText2:
          GoogleFonts.sourceCodePro(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      button:
          GoogleFonts.sourceCodePro(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption:
          GoogleFonts.sourceCodePro(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline:
          GoogleFonts.sourceCodePro(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ).apply(
      displayColor: displayColor,
      bodyColor: bodyColor,
    );
    return GoogleFonts.sourceCodeProTextTheme(currentTextTheme);
  }
}
