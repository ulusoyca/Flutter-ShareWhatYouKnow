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
import 'package:ulusoyapps_flutter/002-navigator-2/002-03-mobile-only-with-auth-and-bootstrap/router/pages/color_page_03.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-03-mobile-only-with-auth-and-bootstrap/router/pages/home_page_03.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-03-mobile-only-with-auth-and-bootstrap/router/pages/login_page_03.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-03-mobile-only-with-auth-and-bootstrap/router/pages/shape_page_03.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-03-mobile-only-with-auth-and-bootstrap/router/pages/splash_page_03.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/data/auth_repository.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/data/colors_repository.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

class MyAppRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  final ColorsRepository colorsRepository;

  bool _loggedIn;
  bool get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

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

  List<Color> _colors;
  List<Color> get colors => _colors;
  set colors(List<Color> value) {
    _colors = value;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate(this.authRepository, this.colorsRepository) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    loggedIn = await authRepository.isUserLoggedIn();
    if (loggedIn) {
      colors = await colorsRepository.fetchColors();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    if (loggedIn == null || (loggedIn && colors == null)) {
      stack = _splashStack;
    } else if (loggedIn) {
      stack = _loggedInStack;
    } else {
      stack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (selectedShapeBorderType == null) selectedColorCode = null;
        selectedShapeBorderType = null;
        return true;
      },
    );
  }

  List<Page> get _splashStack {
    String process;
    if (loggedIn == null) {
      process = 'Checking login state...';
    } else if (colors == null) {
      process = 'Fetching colors...';
    }
    return [
      SplashPage(process: process),
    ];
  }

  List<Page> get _loggedOutStack =>
      [
        LoginPage(onLogin: () async {
          loggedIn = true;
          colors = await colorsRepository.fetchColors();
        })
      ];

  List<Page> get _loggedInStack {
    final onLogout = () async {
      loggedIn = false;
      _clear();
    };
    return [
      HomePage(
        onColorTap: (String colorCode) {
          selectedColorCode = colorCode;
        },
        colors: colors,
        onLogout: onLogout,
      ),
      if (selectedColorCode != null)
        ColorPage(
          selectedColorCode: selectedColorCode,
          onShapeTap: (ShapeBorderType shape) {
            this.selectedShapeBorderType = shape;
          },
          onLogout: onLogout,
        ),
      if (selectedShapeBorderType != null)
        ShapePage(
          colorCode: selectedColorCode,
          shapeBorderType: selectedShapeBorderType,
          onLogout: onLogout,
        )
    ];
  }

  _clear() {
    selectedColorCode = null;
    selectedShapeBorderType = null;
    colors = null;
  }

  Future<void> setNewRoutePath(configuration) async { /* Do Nothing */ }
}
