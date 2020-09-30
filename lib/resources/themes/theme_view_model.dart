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
import 'package:ulusoyapps_flutter/resources/colors/app_colors.dart';
import 'package:ulusoyapps_flutter/resources/themes/text/app_text_theme.dart';

import 'app_theme.dart';
import 'app_theme_data.dart';

class ThemeViewModel with ChangeNotifier {
  final Preference preference;

  static const String KEY_PREFERRED_BRIGHTNESS = 'PREFERRED_BRIGHTNESS';
  static const String _DARK_BRIGHTNESS = 'PREFERRED_BRIGHTNESS';
  static const String _LIGHT_BRIGHTNESS = 'PREFERRED_BRIGHTNESS';
  static const Brightness DEFAULT_BRIGHTNESS = Brightness.dark;

  static const Map<Brightness, String> _brightness = {
    Brightness.dark: _DARK_BRIGHTNESS,
    Brightness.light: _LIGHT_BRIGHTNESS,
  };

  AppTheme _currentTheme;
  AppColors get appColors => _currentTheme.colors;
  TextTheme get baseTextTheme => _currentTheme.textTheme.baseTextTheme;
  Brightness get brightness => _currentTheme.brightness;
  ThemeData get themeData => _currentTheme.themeData;

  ThemeViewModel(this.preference) {
    _currentTheme = _buildTheme(DEFAULT_BRIGHTNESS);
    _currentBrightness.then((value) {
      _buildTheme(value);
      notifyListeners();
    });
  }

  Future<Brightness> get _currentBrightness async {
    final String preferredBrightness = await preference.getString(KEY_PREFERRED_BRIGHTNESS, defaultValue: '');
    if (preferredBrightness.isEmpty) {
      return MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;
    } else {
      return _brightness.entries.firstWhere((element) => element.value == preferredBrightness).key;
    }
  }

  toggleBrightness() {
    String toBeUpdatedBrightness;
    if (_currentTheme.brightness == Brightness.dark) {
      _currentTheme = _buildTheme(Brightness.light);
      toBeUpdatedBrightness = _LIGHT_BRIGHTNESS;
    } else {
      _currentTheme = _buildTheme(Brightness.dark);
      toBeUpdatedBrightness = _DARK_BRIGHTNESS;
    }
    preference.putString(KEY_PREFERRED_BRIGHTNESS, toBeUpdatedBrightness);
    notifyListeners();
  }

  AppTheme _buildTheme(Brightness brightness) {
    final colors = AppColors.buildAppColors(brightness == Brightness.dark);
    final textTheme = AppTextTheme.buildAppTextTheme(appColors: colors);
    final themeData = AppThemeData.buildThemeData(
      brightness: brightness,
      appColors: colors,
      appTextTheme: textTheme,
    );
    return AppTheme(
      themeData: themeData,
      colors: colors,
      textTheme: textTheme,
      brightness: brightness,
    );
  }
}
