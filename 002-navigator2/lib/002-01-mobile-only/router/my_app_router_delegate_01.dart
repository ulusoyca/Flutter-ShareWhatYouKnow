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
import 'package:navigator_2/002-01-mobile-only/router/pages/color_page_01.dart';
import 'package:navigator_2/002-01-mobile-only/router/pages/home_page_01.dart';
import 'package:navigator_2/002-01-mobile-only/router/pages/shape_page_01.dart';

class MyAppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate();

  String? _selectedColorCode;
  String? get selectedColorCode => _selectedColorCode;
  set selectedColorCode(String? value) {
    _selectedColorCode = value;
    notifyListeners();
  }

  ShapeBorderType? _selectedShapeBorderType;
  ShapeBorderType? get selectedShapeBorderType => _selectedShapeBorderType;
  set selectedShapeBorderType(ShapeBorderType? value) {
    _selectedShapeBorderType = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final selectedShapeBorderType = this.selectedShapeBorderType;
    final selectedColorCode = this.selectedColorCode;
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage(
          onColorTap: (String colorCode) {
            this.selectedColorCode = colorCode;
          },
        ),
        if (selectedColorCode != null)
          ColorPage(
            selectedColorCode: selectedColorCode,
            onShapeTap: (ShapeBorderType shape) {
              this.selectedShapeBorderType = shape;
            },
          ),
        if (selectedColorCode != null && selectedShapeBorderType != null)
          ShapePage(
            colorCode: selectedColorCode,
            shapeBorderType: selectedShapeBorderType,
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (selectedShapeBorderType == null) this.selectedColorCode = null;
        this.selectedShapeBorderType = null;
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {/* Do Nothing */}
}
