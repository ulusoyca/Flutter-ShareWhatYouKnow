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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/router/my_app_router_delegate_02.dart';
import 'package:navigator_2/data/auth_repository.dart';
import 'package:navigator_2/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyAppRouterDelegate delegate;
  AuthRepository? authRepository;

  @override
  void initState() {
    super.initState();
    delegate = MyAppRouterDelegate(AuthRepository(Preference()));
    authRepository = AuthRepository(Preference());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) => AuthViewModel(authRepository),
      child: MaterialApp(
          home: Router(
        routerDelegate: delegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      )),
    );
  }
}
