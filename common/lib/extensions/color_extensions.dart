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

extension HexColor on Color {
  String toHex({bool leadingHashSign = false, bool includeAlpha = false}) => '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  onTextColor() {
    Brightness brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.light ? Colors.black : Colors.white;
  }
}

extension HexString on String {
  hexToColor() {
    return new Color(int.parse(this.substring(0, 6), radix: 16) + 0xFF000000);
  }

  bool isHexColor() {
    return RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(this);
  }
}
