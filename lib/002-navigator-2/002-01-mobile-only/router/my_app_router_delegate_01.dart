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
import 'package:ulusoyapps_flutter/002-navigator-2/002-01-mobile-only/router/pages/color_page_01.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-01-mobile-only/router/pages/home_page_01.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-01-mobile-only/router/pages/shape_page_01.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class MyAppRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  String _selectedColorCode;
  String get selectedColorCode => _selectedColorCode;
  set selectedColorCode(String value) {
    _selectedColorCode = value;
    notifyListeners();
  }

  ShapeBorderType _selectedShapeBorderType;
  ShapeBorderType get selectedShapeBorderType => _selectedShapeBorderType;
  set selectedShapeBorderType(ShapeBorderType value) {
    _selectedShapeBorderType = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage(
          onColorTap: (String colorCode) {
            selectedColorCode = colorCode;
            notifyListeners();
          },
        ),
        if (selectedColorCode != null)
          ColorPage(
            selectedColorCode: selectedColorCode,
            onShapeTap: (ShapeBorderType shape) {
              selectedShapeBorderType = shape;
            },
          ),
        if (selectedShapeBorderType != null)
          ShapePage(
            colorCode: selectedColorCode,
            shapeBorderType: selectedShapeBorderType,
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (selectedShapeBorderType == null) selectedColorCode = null;
        selectedShapeBorderType = null;
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async { /* Do Nothing */ }
}
