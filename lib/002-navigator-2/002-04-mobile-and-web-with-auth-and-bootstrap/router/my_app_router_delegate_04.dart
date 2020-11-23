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
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/router/pages/color_page_04.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/router/pages/home_page_04.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/router/pages/login_page_04.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/router/pages/shape_page_04.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/router/pages/splash_page_04.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/router/pages/unknown_page_04.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/data/auth_repository.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/data/colors_repository.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';

import 'my_app_configuration.dart';

class MyAppRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {

  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  final ColorsRepository colorsRepository;

  bool _show404;
  bool get show404 => _show404;
  set show404(bool value) {
    _show404 = value;
    if (value == true) {
      selectedColorCode = null;
      selectedShapeBorderType = null;
    }
    notifyListeners();
  }

  bool _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(value) {
    _isLoggedIn = value;
    if (value == false) _clear();
    notifyListeners();
  }

  List<Color> _colors;
  List<Color> get colors => _colors;
  set colors(List<Color> value) {
    _colors = value;
    if (value != null && selectedColorCode != null) {
      show404 = !_isValidColor(selectedColorCode);
    }
    notifyListeners();
  }

  String _selectedColorCode;
  String get selectedColorCode => _selectedColorCode;
  set selectedColorCode(String value) {
    if (colors != null && value != null) {
      show404 = !_isValidColor(value);
    }
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
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate(this.authRepository, this.colorsRepository) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isUserLoggedIn();
    if (isLoggedIn == true) {
      colors = await colorsRepository.fetchColors();
    }
  }

  @override
  MyAppConfiguration get currentConfiguration {
    if (isLoggedIn == false) {
      return MyAppConfiguration.login();
    } else if (isLoggedIn == null) {
      return MyAppConfiguration.splash();
    } else if (show404 == true) {
      return MyAppConfiguration.unknown();
    } else if (selectedColorCode == null) {
      return MyAppConfiguration.home();
    } else if (selectedShapeBorderType == null) {
      return MyAppConfiguration.color(selectedColorCode);
    } else if (selectedShapeBorderType != null) {
      return MyAppConfiguration.shapeBorder(selectedColorCode, selectedShapeBorderType);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    if (show404 == true) {
      stack = _unknownStack;
    }else if (isLoggedIn == null || (isLoggedIn && colors == null)) {
      stack = _splashStack;
    } else if (isLoggedIn) {
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
    if (isLoggedIn == null) {
      process = 'Checking login state...';
    } else if (colors == null) {
      process = 'Fetching colors...';
    }
    return [
      SplashPage(process: process),
    ];
  }

  List<Page> get _unknownStack => [UnknownPage()];

  List<Page> get _loggedOutStack => [
        LoginPage(onLogin: () async {
          isLoggedIn = true;
          colors = await colorsRepository.fetchColors();
        })
      ];

  List<Page> get _loggedInStack {
    final onLogout = () async {
      isLoggedIn = false;
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
          onShapeTap: (ShapeBorderType shapeBorderType) {
            selectedShapeBorderType = shapeBorderType;
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

  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async {
    if (configuration.unknown) {
      show404 = true;
    } else if (configuration.isHomePage || configuration.isLoginPage || configuration.isSplashPage) {
      show404 = false;
      selectedColorCode = null;
      selectedShapeBorderType = null;
    } else if (configuration.isColorPage) {
      show404 = false;
      selectedColorCode = configuration.colorCode;
      selectedShapeBorderType = null;
    } else if (configuration.isShapePage) {
      show404 = false;
      selectedColorCode = configuration.colorCode;
      selectedShapeBorderType = configuration.shapeBorderType;
    } else {
      print(' Could not set new route');
    }
  }

  _clear() {
    selectedColorCode = null;
    selectedShapeBorderType = null;
    colors = null;
    show404 = null;
  }

  bool _isValidColor(String colorCode) {
    final List<String> colorCodes = colors.map((e) {
      return e.toHex();
    }).toList();
    return colorCodes.contains("$colorCode");
  }
}
