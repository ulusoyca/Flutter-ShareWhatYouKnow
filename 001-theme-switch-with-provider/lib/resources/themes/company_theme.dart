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
import 'package:theme_switch_with_provider/resources/colors/ata_colors.dart';
import 'package:theme_switch_with_provider/resources/colors/biohack_colors.dart';
import 'package:theme_switch_with_provider/resources/colors/codeland_colors.dart';
import 'package:theme_switch_with_provider/resources/colors/company_colors.dart';
import 'package:theme_switch_with_provider/resources/icon/ata_icons.dart';
import 'package:theme_switch_with_provider/resources/icon/biohack_icons.dart';
import 'package:theme_switch_with_provider/resources/icon/codeland_icons.dart';
import 'package:theme_switch_with_provider/resources/icon/company_icons.dart';
import 'package:theme_switch_with_provider/resources/shape/ata_shapes.dart';
import 'package:theme_switch_with_provider/resources/shape/biohack_shapes.dart';
import 'package:theme_switch_with_provider/resources/shape/codeland_shapes.dart';
import 'package:theme_switch_with_provider/resources/shape/company_shapes.dart';
import 'package:theme_switch_with_provider/resources/themes/text/ata_text_theme.dart';
import 'package:theme_switch_with_provider/resources/themes/text/biohack_text_theme.dart';
import 'package:theme_switch_with_provider/resources/themes/text/codeland_text_theme.dart';
import 'package:theme_switch_with_provider/resources/themes/text/company_text_theme.dart';
import 'package:theme_switch_with_provider/resources/themes/theme_data/ata_theme_data.dart';
import 'package:theme_switch_with_provider/resources/themes/theme_data/biohack_theme_data.dart';
import 'package:theme_switch_with_provider/resources/themes/theme_data/codeland_theme_data.dart';

class CompanyTheme {
  final Brightness brightness;
  late CompanyColors colors;
  late CompanyTextTheme textTheme;
  late CompanyShapes shapes;
  late CompanyIcons icons;
  late ThemeData themeData;

  CompanyTheme.ata(this.brightness) {
    colors = AtaColors(brightness);
    textTheme = AtaTextTheme(colors);
    shapes = AtaShapes(colors);
    icons = AtaIcons();
    themeData = AtaThemeData(brightness, colors, textTheme, shapes).themeData;
  }

  CompanyTheme.biohack(this.brightness) {
    colors = BiohackColors(brightness);
    textTheme = BiohackTextTheme(colors);
    shapes = BiohackShapes(colors);
    icons = BiohackIcons();
    themeData = BiohackThemeData(brightness, colors, textTheme, shapes).themeData;
  }

  CompanyTheme.codeland(this.brightness) {
    colors = CodelandColors(brightness);
    textTheme = CodelandTextTheme(colors);
    shapes = CodelandShapes(colors);
    icons = CodelandIcons();
    themeData = CodelandThemeData(brightness, colors, textTheme, shapes).themeData;
  }
}
