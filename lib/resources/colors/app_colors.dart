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
  /// Base Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF59DD00);
  static const Color brightSun = Color(0xFFFCC94A);
  static const Color balticSea = Color(0xFF18171d); // 900
  static const Color raisinBlack = Color(0xFF242329); // 900
  static const Color darkGrey = Color(0xFF121212);
  static const Color onyx = Color(0xFF45444B); // 900
  static const Color alabaster = Color(0xFFFAFAFA);
  static const Color abbey = Color(0xFF464648);
  static const Color dimGray = Color(0xFF666666);
  static const Color shadow = Color.fromRGBO(33, 22, 156, 0.1);
  static const Color whisper = Color(0xFFECECF4);

  static const Map<int, Color> bluePurpleSwatch = {
    50: Color(0xFFefe8fa),
    100: Color(0xFFd5c6f2),
    200: Color(0xFFb9a0ea),
    300: Color(0xFF9c78e3),
    400: Color(0xFF8559dc),
    500: Color(0xFF6d3bd5),
    600: Color(0xFF6235ce),
    700: Color(0xFF532dc5),
    800: Color(0xFF4427be),
    900: Color(0xFF2b1bb0),
  };

  static const MaterialColor bluePurple = MaterialColor(
    0xFF6d3bd5,
    bluePurpleSwatch,
  );

  static const Map<int, Color> turquoiseSwatch = {
    50: Color(0xFFdff8f7),
    100: Color(0xFFb1edec),
    200: Color(0xFF7de1e2),
    400: Color(0xFF00cad1),
    700: Color(0xFF009ba1),
  };

  static const MaterialAccentColor turquoise = MaterialAccentColor(
    0xFF7de1e2,
    turquoiseSwatch,
  );

  static const Map<int, Color> capriSwatch = {
    50: Color(0xFFe1f6ff),
    100: Color(0xFFb2e7ff),
    200: Color(0xFF7ed7ff),
    300: Color(0xFF7ed7ff),
    400: Color(0xFF00bbff),
    500: Color(0xFF00afff),
    600: Color(0xFF00a0f0),
    700: Color(0xFF008ddb),
    800: Color(0xFF007cc8),
    900: Color(0xFF005ba5),
  };

  static const MaterialColor capri = MaterialColor(
    0xFF00afff,
    capriSwatch,
  );

  static const Map<int, Color> roseSwatch = {
    100: Color(0xFFfcbcd0),
    200: Color(0xFFfa91b0),
    400: Color(0xFFf54378),
    700: Color(0xFFcb1b5a),
  };

  static const MaterialAccentColor rose = MaterialAccentColor(
    0xFFfa91b0,
    roseSwatch,
  );

  static const Map<int, Color> slateGreySwatch = {
    50: Color(0xFFe8f0f7),
    100: Color(0xFFcad9e2),
    200: Color(0xFFacbfcb),
    300: Color(0xFF8da6b5),
    400: Color(0xFF7592a3),
    500: Color(0xFF5d7f92),
    600: Color(0xFF517081),
    700: Color(0xFF425c6a),
    800: Color(0xFF344955),
    900: Color(0xFF23343d),
  };

  static const MaterialColor slateGrey = MaterialColor(
    0xFF5d7f92,
    slateGreySwatch,
  );

  static const Map<int, Color> orangeRedSwatch = {
    100: Color(0xFFfecfbf),
    200: Color(0xFFfeb096),
    400: Color(0xFFff7a4c),
    700: Color(0xFFe65824),
  };

  static const MaterialAccentColor orangeRed = MaterialAccentColor(
    0xFFfeb096,
    orangeRedSwatch,
  );

  static const Map<int, Color> veroneseGreenSwatch = {
    100: Color(0xFFaae3d8),
    200: Color(0xFF6dd2bf),
    400: Color(0xFF00b092),
    700: Color(0xFF008164),
  };

  static const MaterialAccentColor veroneseGreen = MaterialAccentColor(
    0xFF6dd2bf,
    veroneseGreenSwatch,
  );

  static const Map<int, Color> tomatoSwatch = {
    100: Color(0xFFffd2d6),
    200: Color(0xFFf4a3a1),
    400: Color(0xFFf8635a),
    700: Color(0xFFde4239),
  };

  static const MaterialAccentColor tomato = MaterialAccentColor(
    0xFFf4a3a1,
    tomatoSwatch,
  );

  static const Map<int, Color> vividSkySwatch = {
    100: Color(0xFF9ff2fe),
    200: Color(0xFF42e9ff),
    400: Color(0xFF00d5f7),
    700: Color(0xFF00a6c3),
  };

  static const MaterialAccentColor vividSky = MaterialAccentColor(
    0xFF42e9ff,
    vividSkySwatch,
  );

  static const Map<int, Color> champagneSwatch = {
    50: Color(0xFFfaf4e4),
    100: Color(0xFFf3e2ba),
    200: Color(0xFFEDCF8E),
    400: Color(0xFFe6ad3a),
    700: Color(0xFFdb8612),
  };

  static const MaterialAccentColor champagne = MaterialAccentColor(
    0xFFEDCF8E,
    champagneSwatch,
  );

  static const Map<int, Color> mauveSwatch = {
    100: Color(0xFFd6afc6),
    200: Color(0xFFBA7BA1),
    400: Color(0xFF8f156a),
    700: Color(0xFF65004d),
  };

  static const mauve = MaterialAccentColor(
    0xFFBA7BA1,
    mauveSwatch,
  );

  static const Map<int, Color> coffeeSwatch = {
    50: Color(0xFFf5eae3),
    200: Color(0xFFc2ab9f),
    700: Color(0xFF43281f),
  };

  static const coffee = MaterialAccentColor(
    0xFFc2ab9f,
    coffeeSwatch,
  );
}

class HeatmapColors {
  final HSVColor start;
  final HSVColor end;

  HeatmapColors({
    this.start,
    this.end,
  });

  Color getColor(double weight) {
    return HSVColor.lerp(start, end, weight).toColor();
  }
}
