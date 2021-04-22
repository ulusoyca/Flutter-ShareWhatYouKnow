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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-05-web-with-route-state/widgets/color_gridview_05.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-05-web-with-route-state/widgets/shaped_color_list_05.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class HomeScreen extends StatelessWidget {
  final List<Color> colors;
  final ValueListenable<ShapeBorderType> selectedShapeBorderType;
  final ValueNotifier<String> selectedColorCode;
  final ValueListenable<String> colorCodeFromBrowserHistory;

  HomeScreen({
    Key key,
    this.colors,
    this.selectedShapeBorderType,
    this.selectedColorCode,
    this.colorCodeFromBrowserHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          Material(
            elevation: 4.0,
            child: ColorGrid(
              colors: colors,
              selectedColorCode: selectedColorCode,
            ),
          ),
          Expanded(
            child: ShapedColorList(
              colors: colors,
              selectedColorCode: selectedColorCode,
              selectedShapeBorderType: selectedShapeBorderType,
              colorCodeFromBrowserHistory: colorCodeFromBrowserHistory,
            ),
          ),
        ],
      ),
    );
  }
}
