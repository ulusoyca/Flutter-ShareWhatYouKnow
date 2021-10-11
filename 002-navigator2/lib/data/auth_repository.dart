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

import 'package:common/cache/preference.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  final Preference preference;

  AuthRepository(this.preference);

  Future<bool> isUserLoggedIn() async => Future.delayed(Duration(seconds: 2)).then((value) {
        return preference.getBool(_AUTH_KEY, defaultValue: false);
      });

  Future<bool> _updateLoginStatus(bool loggedIn) =>
      Future.delayed(Duration(seconds: 2)).then((value) {
        return preference.putBool(_AUTH_KEY, loggedIn);
      });

  Future<bool> logout() => _updateLoginStatus(false);

  Future<bool> login() => _updateLoginStatus(true);
}
