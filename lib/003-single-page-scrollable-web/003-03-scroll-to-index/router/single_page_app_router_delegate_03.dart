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
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

import 'pages/home_page_02.dart';
import 'pages/shape_page_02.dart';
import 'pages/unknown_page_02.dart';
import 'single_page_app_configuration_03.dart';

class SinglePageAppRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {
  final List<Color> colors;
  final GlobalKey<NavigatorState> _navigatorKey;

  // App state fields
  final ValueNotifier<String> _selectedColorCode = ValueNotifier(null);
  final ValueNotifier<ShapeBorderType> _selectedShapeBorderType = ValueNotifier(null);
  final ValueNotifier<bool> _unknownState = ValueNotifier(null);

  SinglePageAppRouterDelegate({this.colors}) : _navigatorKey = GlobalKey<NavigatorState>() {
    final _appStateListenable = Listenable.merge([_selectedColorCode, _selectedShapeBorderType, _unknownState]);
    _appStateListenable.addListener(() {
      if (_unknownState.value == true) {
        _selectedColorCode.value = null;
        _selectedShapeBorderType.value = null;
      }
      notifyListeners();
    });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  MyAppConfiguration get currentConfiguration {
    if (_unknownState.value == true) {
      return MyAppConfiguration.unknown();
    } else if (_selectedShapeBorderType != null) {
      final color = _selectedColorCode.value;
      final shapeBorderType = _selectedShapeBorderType.value;
      return MyAppConfiguration.shapeBorder(color, shapeBorderType);
    } else {
      return MyAppConfiguration.home(selectedColorCode: _selectedColorCode.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _unknownState.value == true
          ? [UnknownPage()]
          : [
              HomePage(
                colors: colors,
                selectedColorCode: _selectedColorCode,
                selectedShapeBorderType: _selectedShapeBorderType,
              ),
              if (_selectedColorCode.value != null && _selectedShapeBorderType.value != null)
                ShapePage(
                  colorCode: _selectedColorCode.value,
                  shapeBorderType: _selectedShapeBorderType.value,
                )
            ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_selectedShapeBorderType.value == null) _selectedColorCode.value = null;
        _selectedShapeBorderType.value = null;
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async {
    if (configuration.unknown) {
      _unknownState.value = true;
    } else if (configuration.isHomePage) {
      _unknownState.value = false;
      _selectedColorCode.value = configuration.selectedColorCode;
      _selectedShapeBorderType.value = null;
    } else if (configuration.isShapePage) {
      _unknownState.value = false;
      _selectedColorCode.value = configuration.selectedColorCode;
      _selectedShapeBorderType.value = configuration.shapeBorderType;
    } else {
      print(' Could not set new route');
    }
  }
}
