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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

import 'pages/home_page_03.dart';
import 'pages/shape_page_03.dart';
import 'pages/unknown_page_03.dart';
import 'single_page_app_configuration_03.dart';

class SinglePageAppRouterDelegate extends RouterDelegate<SinglePageAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SinglePageAppConfiguration> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final List<MaterialColor> colors;

  // App state fields
  final ValueNotifier<String> _selectedColorCodeByUserScrollNotifier = ValueNotifier(null);
  final ValueNotifier<String> _selectedColorCodeByMenuClickNotifier = ValueNotifier(null);
  final ValueNotifier<ShapeBorderType> _selectedShapeBorderTypeNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _unknownStateNotifier = ValueNotifier(null);
  String _selectedColorCode;

  SinglePageAppRouterDelegate({this.colors}) : _navigatorKey = GlobalKey<NavigatorState>() {
    _selectedColorCodeByUserScrollNotifier.addListener(() {
      _selectedColorCode = _selectedColorCodeByUserScrollNotifier.value;
    });
    _selectedColorCodeByMenuClickNotifier.addListener(() {
      _selectedColorCode = _selectedColorCodeByMenuClickNotifier.value;
    });
    Listenable.merge([
      _selectedColorCodeByUserScrollNotifier,
      _selectedColorCodeByMenuClickNotifier,
      _selectedShapeBorderTypeNotifier,
      _unknownStateNotifier,
    ])
      ..addListener(() {
        print("notifying the router widget");
        notifyListeners();
      });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  SinglePageAppConfiguration get currentConfiguration {
    if (_unknownStateNotifier.value == true) {
      return SinglePageAppConfiguration.unknown();
    } else if (_selectedShapeBorderTypeNotifier.value != null) {
      return SinglePageAppConfiguration.shapeBorder(
        _selectedColorCodeByMenuClickNotifier.value,
        _selectedShapeBorderTypeNotifier.value,
      );
    } else {
      return SinglePageAppConfiguration.home(selectedColorCode: _selectedColorCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _unknownStateNotifier.value == true
          ? [
              UnknownPage(),
            ]
          : [
              HomePage(
                colors: colors,
                selectedColorCodeByUserScrollNotifier: _selectedColorCodeByUserScrollNotifier,
                selectedColorCodeByMenuClickNotifier: _selectedColorCodeByMenuClickNotifier,
                selectedShapeBorderTypeNotifier: _selectedShapeBorderTypeNotifier,
              ),
              if (_selectedColorCode != null && _selectedShapeBorderTypeNotifier.value != null)
                ShapePage(
                  colorCode: _selectedColorCode,
                  shapeBorderType: _selectedShapeBorderTypeNotifier.value,
                )
            ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (route.settings.name == ShapePage.routeName) {
          _selectedShapeBorderTypeNotifier.value = null;
          if (result == null) {
            print("Clicked on barrier");
          } else {
            print("Clicked submit: $result");
          }
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(SinglePageAppConfiguration configuration) async {
    if (configuration.unknown) {
      _unknownStateNotifier.value = true;
      _selectedColorCodeByUserScrollNotifier.value = null;
      _selectedColorCodeByMenuClickNotifier.value = null;
      _selectedShapeBorderTypeNotifier.value = null;
    } else if (configuration.isHomePage) {
      _unknownStateNotifier.value = false;
      _selectedColorCodeByMenuClickNotifier.value = configuration.selectedColorCode;
      _selectedShapeBorderTypeNotifier.value = null;
    } else if (configuration.isShapePage) {
      _unknownStateNotifier.value = false;
      _selectedColorCodeByMenuClickNotifier.value = configuration.selectedColorCode;
      _selectedShapeBorderTypeNotifier.value = configuration.shapeBorderType;
    } else {
      print(' Could not set new route');
    }
  }
}
