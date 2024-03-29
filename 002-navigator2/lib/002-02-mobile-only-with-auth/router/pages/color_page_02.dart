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

import 'package:common/model/shape_border_type.dart';
import 'package:flutter/material.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/color_screen_02.dart';

class ColorPage extends Page {
  final Function(ShapeBorderType) onShapeTap;
  final String selectedColorCode;
  final VoidCallback onLogout;

  ColorPage({
    required this.onLogout,
    required this.selectedColorCode,
    required this.onShapeTap,
  }) : super(key: ValueKey(selectedColorCode));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return ColorScreen(
          onShapeTap: onShapeTap,
          colorCode: selectedColorCode,
          onLogout: onLogout,
        );
      },
    );
  }
}
