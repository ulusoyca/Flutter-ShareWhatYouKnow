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
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/entity/color_selection.dart';

import '../home_screen_04.dart';
import '../shape_dialog_04.dart';
import '../unknown_screen_04.dart';
import 'single_page_app_configuration_04.dart';

class ShapePage extends Page {
  final String colorCode;
  final ShapeBorderType shapeBorderType;

  static const String routeName = "ShapePage";

  @override
  String get name => routeName;

  ShapePage({
    @required this.shapeBorderType,
    @required this.colorCode,
  }) : super(key: ValueKey("$colorCode$shapeBorderType"));

  @override
  Route createRoute(BuildContext context) {
    return CupertinoDialogRoute(
      settings: this,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (BuildContext context) => ShapeDialog(colorCode: colorCode, shapeBorderType: shapeBorderType),
      context: context,
    );
  }
}

class SinglePageAppRouterDelegate extends RouterDelegate<SinglePageAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SinglePageAppConfiguration> {
  final List<MaterialColor> colors;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  Page _homePage;

  // App state fields
  final ValueNotifier<ColorCodeSelection> _selectedColorCodeNotifier = ValueNotifier(null);
  final ValueNotifier<ShapeBorderType> _selectedShapeBorderTypeNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _unknownStateNotifier = ValueNotifier(null);

  SinglePageAppRouterDelegate({this.colors}) {
    _homePage = MaterialPage(
      key: ValueKey<String>("HomePage"),
      child: HomeScreen(
        colors: colors,
        selectedColorCodeNotifier: _selectedColorCodeNotifier,
        selectedShapeBorderTypeNotifier: _selectedShapeBorderTypeNotifier,
      ),
    );
    Listenable.merge([
      _selectedShapeBorderTypeNotifier,
      _unknownStateNotifier,
      _selectedColorCodeNotifier,
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
        _selectedColorCodeNotifier.value.hexColorCode,
        _selectedShapeBorderTypeNotifier.value,
      );
    } else {
      return SinglePageAppConfiguration.home(
        selectedColorCode: _selectedColorCodeNotifier.value.hexColorCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _unknownStateNotifier.value == true
          ? [
              MaterialPage(
                key: ValueKey<String>("Unknown"),
                child: UnknownScreen(),
              )
            ]
          : [
              _homePage,
              if (_selectedColorCodeNotifier.value != null && _selectedShapeBorderTypeNotifier.value != null)
                ShapePage(
                  colorCode: _selectedColorCodeNotifier.value.hexColorCode,
                  shapeBorderType: _selectedShapeBorderTypeNotifier.value,
                ),
            ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (route.settings.name == ShapePage.routeName) {
          _selectedShapeBorderTypeNotifier.value = null;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(SinglePageAppConfiguration configuration) async {
    if (configuration.unknown) {
      _unknownStateNotifier.value = true;
      _selectedColorCodeNotifier.value = null;
      _selectedShapeBorderTypeNotifier.value = null;
    } else if (configuration.isHomePage) {
      _unknownStateNotifier.value = false;
      _selectedColorCodeNotifier.value = ColorCodeSelection(
        hexColorCode: configuration.colorCode,
        source: ColorCodeSelectionSource.fromBrowserAddressBar,
      );
      _selectedShapeBorderTypeNotifier.value = null;
    } else if (configuration.isShapePage) {
      _unknownStateNotifier.value = false;
      _selectedColorCodeNotifier.value = ColorCodeSelection(
        hexColorCode: configuration.colorCode,
        source: ColorCodeSelectionSource.fromBrowserAddressBar,
      );
      _selectedShapeBorderTypeNotifier.value = configuration.shapeBorderType;
    } else {
      print(' Could not set new route');
    }
  }
}
