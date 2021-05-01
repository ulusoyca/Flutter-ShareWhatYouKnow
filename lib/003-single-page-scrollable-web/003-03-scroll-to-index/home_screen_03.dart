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
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-03-scroll-to-index/widgets/shaped_color_listview_03.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/top_navigation_menu.dart';

class HomeScreen extends StatelessWidget {
  final List<MaterialColor> colors;
  final ValueListenable<ShapeBorderType> selectedShapeBorderTypeNotifier;
  final ValueNotifier<String> selectedColorCodeNotifier;

  HomeScreen({
    Key key,
    this.colors,
    this.selectedShapeBorderTypeNotifier,
    this.selectedColorCodeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 4.0,
            child: TopNavigationMenu(
              colors: colors,
              selectedColorCodeNotifier: selectedColorCodeNotifier,
            ),
          ),
          Expanded(
            child: ShapedColorList(
              colors: colors,
              selectedShapeBorderTypeNotifier: selectedShapeBorderTypeNotifier,
              selectedColorCodeNotifier: selectedColorCodeNotifier,
            ),
          ),
        ],
      ),
    );
  }
}
