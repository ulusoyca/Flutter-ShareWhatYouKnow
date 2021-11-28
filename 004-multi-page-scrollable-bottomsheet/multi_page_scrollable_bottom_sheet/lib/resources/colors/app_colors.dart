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
  AppColors._();

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color blue = Color(0xFF009DE0);
  static const Color red = Colors.red;
  static const Color green = Colors.green;

  static const Color white60 = Colors.white60;
  static const Color black60 = Color(0xFF707174);
  static const Color blue60 = Color(0xFF5CC0EB);
  static const Color red60 = Color(0xFFf8635a);
  static const Color green60 = Color(0xFF78e344);

  static const Color white38 = Colors.white38;
  static const Color black38 = Color(0xFFAFAFB0);
  static const Color blue38 = Color(0xFF5CC0EB);
  static const Color red38 = Color(0xFFf4a3a1);
  static const Color green38 = Color(0xFFb7f09a);

  static const Color white24 = Colors.white24;
  static const Color black24 = Color(0xFFCACACB);
  static const Color blue24 = Color(0xFFD6EFFA);
  static const Color red24 = Color(0xFFffd2d6);
  static const Color green24 = Color(0xFFd5f6c2);

  static const Color white10 = Colors.white10;
  static const Color black10 = Color(0xFFF2F2F2);
  static const Color blue10 = Color(0xFFEBF8FD);
  static const Color red10 = Color(0xFFffedef);
  static const Color green10 = Color(0xFFeefce7);
}

enum AppColorNames {
  white,
  blue,
  red,
  green,
  black,
}

extension NumberedColors on AppColorNames {
  Color get color100 {
    switch (this) {
      case AppColorNames.white:
        return AppColors.white;
      case AppColorNames.black:
        return AppColors.black;
      case AppColorNames.blue:
        return AppColors.blue;
      case AppColorNames.red:
        return AppColors.red;
      case AppColorNames.green:
        return AppColors.green;
    }
  }

  Color get color60 {
    switch (this) {
      case AppColorNames.white:
        return AppColors.white60;
      case AppColorNames.black:
        return AppColors.black60;
      case AppColorNames.blue:
        return AppColors.blue60;
      case AppColorNames.red:
        return AppColors.red60;
      case AppColorNames.green:
        return AppColors.green60;
    }
  }

  Color get color38 {
    switch (this) {
      case AppColorNames.white:
        return AppColors.white38;
      case AppColorNames.black:
        return AppColors.black38;
      case AppColorNames.blue:
        return AppColors.blue38;
      case AppColorNames.red:
        return AppColors.red38;
      case AppColorNames.green:
        return AppColors.green38;
    }
  }

  Color get color24 {
    switch (this) {
      case AppColorNames.white:
        return AppColors.white24;
      case AppColorNames.black:
        return AppColors.black24;
      case AppColorNames.blue:
        return AppColors.blue24;
      case AppColorNames.red:
        return AppColors.red24;
      case AppColorNames.green:
        return AppColors.green24;
    }
  }

  Color get color10 {
    switch (this) {
      case AppColorNames.white:
        return AppColors.white10;
      case AppColorNames.black:
        return AppColors.black10;
      case AppColorNames.blue:
        return AppColors.blue10;
      case AppColorNames.red:
        return AppColors.red10;
      case AppColorNames.green:
        return AppColors.green10;
    }
  }
}
