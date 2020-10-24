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
import 'package:ulusoyapps_flutter/cache/Preference.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_colors.dart';
import 'package:ulusoyapps_flutter/resources/icon/company_icons.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_shapes.dart';
import 'package:ulusoyapps_flutter/resources/themes/company_theme_data.dart';

import 'companies.dart';

class ThemePreference {
  final String companyName;
  final Brightness brightness;

  ThemePreference(this.companyName, this.brightness);
}

class ThemeViewModel with ChangeNotifier {
  final Preference preference;

  static const String KEY_PREFERRED_BRIGHTNESS = 'PREFERRED_BRIGHTNESS';
  static const String _DARK_BRIGHTNESS = 'DARK_BRIGHTNESS';
  static const String _LIGHT_BRIGHTNESS = 'LIGHT_BRIGHTNESS';
  static const Brightness DEFAULT_BRIGHTNESS = Brightness.dark;

  static const String _COMPANY_A_NAME = 'COMPANY_A';
  static const String _COMPANY_B_NAME = 'COMPANY_B';
  static const String _COMPANY_C_NAME = 'COMPANY_C';
  static const String KEY_COMPANY = 'COMPANY';
  static const String DEFAULT_COMPANY = _COMPANY_A_NAME;

  static const Map<Brightness, String> _brightness = {
    Brightness.dark: _DARK_BRIGHTNESS,
    Brightness.light: _LIGHT_BRIGHTNESS,
  };

  static const Map<Company, String> _companies = {
    Company.COMPANY_A: _COMPANY_A_NAME,
    Company.COMPANY_B: _COMPANY_B_NAME,
    Company.COMPANY_C: _COMPANY_C_NAME,
  };

  CompanyThemeData _currentTheme;

  CompanyColors get colors => _currentTheme.colors;

  CompanyThemeData get currentTheme => _currentTheme;

  CompanyShapes get shapes => _currentTheme.shapes;

  CompanyIcons get icons => _currentTheme.icons;

  TextTheme get baseTextTheme => _currentTheme.textTheme.baseTextTheme;

  TextTheme get primaryTextTheme => _currentTheme.textTheme.primaryTextTheme;

  Brightness get brightness => _currentTheme.brightness;

  bool get isDark => _currentTheme.brightness == Brightness.dark;

  ThemeViewModel(this.preference) {
    _currentTheme = _buildTheme(ThemePreference(DEFAULT_COMPANY, DEFAULT_BRIGHTNESS));
    _currentThemePreference.then((value) {
      _buildTheme(value);
      notifyListeners();
    });
  }

  Future<ThemePreference> get _currentThemePreference async {
    Brightness brightness;
    final String preferredBrightness = await preference.getString(KEY_PREFERRED_BRIGHTNESS, defaultValue: '');
    if (preferredBrightness.isEmpty) {
      brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;
    } else {
      brightness = _brightness.entries.firstWhere((element) => element.value == preferredBrightness).key;
    }
    String preferredCompany = await preference.getString(KEY_COMPANY, defaultValue: DEFAULT_COMPANY);
    return ThemePreference(preferredCompany, brightness);
  }

  toggleBrightness() {
    final String companyName = _companies.entries.firstWhere((e) => e.key == _currentTheme.company).value;
    String toBeUpdatedBrightness;
    if (_currentTheme.brightness == Brightness.dark) {
      var themePreference = ThemePreference(companyName, Brightness.light);
      _currentTheme = _buildTheme(themePreference);
      toBeUpdatedBrightness = _LIGHT_BRIGHTNESS;
    } else {
      final themePreference = ThemePreference(companyName, Brightness.dark);
      _currentTheme = _buildTheme(themePreference);
      toBeUpdatedBrightness = _DARK_BRIGHTNESS;
    }
    preference.putString(KEY_PREFERRED_BRIGHTNESS, toBeUpdatedBrightness);
    notifyListeners();
  }

  updateCompany(Company company) {
    String companyName = _companies.entries.firstWhere((element) => element.key == company).value;
    preference.putString(KEY_COMPANY, companyName);
    final themePreference = ThemePreference(companyName, _currentTheme.brightness);
    _currentTheme = _buildTheme(themePreference);
    notifyListeners();
  }

  CompanyThemeData _buildTheme(ThemePreference themePreference) {
    final brightness = themePreference.brightness;
    switch (themePreference.companyName) {
      case _COMPANY_A_NAME:
        return CompanyThemeData.companyA(brightness);
      case _COMPANY_B_NAME:
        return CompanyThemeData.companyB(brightness);
      case _COMPANY_C_NAME:
        return CompanyThemeData.companyC(brightness);
    }
  }
}
