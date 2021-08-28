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

import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Preference._();

  static final Preference _instance = Preference._();

  factory Preference() {
    return _instance;
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getString(String key, {required String defaultValue}) async {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString(key) ?? defaultValue;
    });
  }

  putString(String key, String value) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString(key, value);
    });
  }

  Future<bool> getBool(String key, {required bool defaultValue}) async {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(key) ?? defaultValue;
    });
  }

  /// Puts bool [value] and returns true if the operation is success.
  Future<bool> putBool(String key, bool value) async {
    return _prefs.then((SharedPreferences prefs) {
      prefs.setBool(key, value);
      return true;
    });
  }
}
