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

import '../../shape_screen_04.dart';

class ShapePage extends Page {
  final String colorCode;
  final ShapeBorderType shapeBorderType;
  final VoidCallback onLogout;

  ShapePage({
    required this.shapeBorderType,
    required this.colorCode,
    required this.onLogout,
  }) : super(key: ValueKey("$colorCode$shapeBorderType"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return ShapeScreen(
          colorCode: colorCode,
          shapeBorderType: shapeBorderType,
          onLogout: onLogout,
        );
      },
    );
  }
}
