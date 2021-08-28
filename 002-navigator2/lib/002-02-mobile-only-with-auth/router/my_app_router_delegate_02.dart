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
import 'package:navigator_2/002-02-mobile-only-with-auth/router/pages/color_page_02.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/router/pages/home_page_02.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/router/pages/login_page_02.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/router/pages/shape_page_02.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/router/pages/splash_page_02.dart';
import 'package:navigator_2/data/auth_repository.dart';

class MyAppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  bool? _loggedIn;
  bool? get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

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

  final AuthRepository authRepository;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  MyAppRouterDelegate(this.authRepository) {
    _init();
  }

  _init() async {
    loggedIn = await authRepository.isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    if (loggedIn == null) {
      stack = _splashStack;
    } else if (loggedIn!) {
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

  List<Page> get _splashStack => [SplashPage(process: 'Splash Screen:\n\nChecking auth state')];

  List<Page> get _loggedOutStack => [
        LoginPage(onLogin: () {
          loggedIn = true;
        })
      ];

  List<Page> get _loggedInStack {
    final onLogout = () {
      loggedIn = false;
      _clear();
    };
    final selectedShapeBorderType = this.selectedShapeBorderType;
    final selectedColorCode = this.selectedColorCode;
    return [
      HomePage(
        onColorTap: (String colorCode) {
          this.selectedColorCode = colorCode;
        },
        onLogout: onLogout,
      ),
      if (selectedColorCode != null)
        ColorPage(
          selectedColorCode: selectedColorCode,
          onShapeTap: (ShapeBorderType shapeBorderType) {
            this.selectedShapeBorderType = shapeBorderType;
          },
          onLogout: onLogout,
        ),
      if (selectedColorCode != null && selectedShapeBorderType != null)
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
  }

  @override
  Future<void> setNewRoutePath(configuration) async {/* Do Nothing */}
}
