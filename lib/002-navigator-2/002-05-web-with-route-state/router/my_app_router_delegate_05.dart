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
import 'package:ulusoyapps_flutter/002-navigator-2/002-05-web-with-route-state/router/pages/home_page_05.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-05-web-with-route-state/router/pages/shape_page_05.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-05-web-with-route-state/router/pages/unknown_page_05.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

import 'my_app_configuration_05.dart';

class MyAppRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {
  final List<Color> colors;
  final GlobalKey<NavigatorState> _navigatorKey;
  final ValueNotifier<String> _colorCodeFromBrowserHistory = ValueNotifier(null);
  final ValueNotifier<String> _selectedColorCode = ValueNotifier(null);
  final ValueNotifier<ShapeBorderType> _selectedShapeBorderType = ValueNotifier(null);

  bool _show404;

  bool get show404 => _show404;

  set show404(bool value) {
    _show404 = value;
    if (value == true) {
      _selectedColorCode.value = null;
      _selectedShapeBorderType.value = null;
    }
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate({this.colors}) : _navigatorKey = GlobalKey<NavigatorState>() {
    _selectedColorCode.addListener(() => notifyListeners());
    _selectedShapeBorderType.addListener(() => notifyListeners());
  }

  @override
  MyAppConfiguration get currentConfiguration {
    if (show404 == true) {
      return MyAppConfiguration.unknown();
    } else if (_selectedShapeBorderType == null) {
      return MyAppConfiguration.home(selectedColorCode: _selectedColorCode.value);
    } else if (_selectedShapeBorderType != null) {
      final color = _selectedColorCode.value;
      final shapeBorderType = _selectedShapeBorderType.value;
      return MyAppConfiguration.shapeBorder(color, shapeBorderType);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: show404 == true
          ? [UnknownPage()]
          : [
              HomePage(
                colors: colors,
                selectedColorCode: _selectedColorCode,
                selectedShapeBorderType: _selectedShapeBorderType,
                colorCodeFromBrowserHistory: _colorCodeFromBrowserHistory,
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
      show404 = true;
    } else if (configuration.isHomePage) {
      show404 = false;
      _selectedColorCode.value = configuration.selectedColorCode;
      _colorCodeFromBrowserHistory.value = configuration.colorCodeFromBrowserHistory;
      _selectedShapeBorderType.value = null;
    } else if (configuration.isShapePage) {
      show404 = false;
      _selectedColorCode.value = configuration.selectedColorCode;
      _selectedShapeBorderType.value = configuration.shapeBorderType;
    } else {
      print(' Could not set new route');
    }
  }
}
