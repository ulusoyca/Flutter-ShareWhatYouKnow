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
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/003-03-scroll-to-index/router/single_page_app_router_delegate_03.dart';

import '../configure_nonweb.dart' if (dart.library.html) '../configure_web.dart';
import 'router/single_page_app_route_information_parser_03.dart';

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SinglePageAppRouterDelegate delegate;
  SinglePageAppRouteInformationParser parser;
  final _colors = Colors.primaries.reversed.toList();

  @override
  void initState() {
    delegate = SinglePageAppRouterDelegate(colors: _colors);
    parser = SinglePageAppRouteInformationParser(colors: _colors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: delegate,
      routeInformationParser: parser,
    );
  }
}
