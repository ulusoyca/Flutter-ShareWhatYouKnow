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
import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:flutter/material.dart';

import 'my_app_configuration.dart';

class MyAppRouteInformationParser extends RouteInformationParser<MyAppConfiguration> {
  @override
  Future<MyAppConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.length == 0) {
      return MyAppConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'home') {
        return MyAppConfiguration.home();
      } else if (first == 'login') {
        return MyAppConfiguration.login();
      } else {
        return MyAppConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'colors' && second.length == 6 && second.isHexColor()) {
        return MyAppConfiguration.color(second);
      } else {
        return MyAppConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 3) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final third = uri.pathSegments[2].toLowerCase();
      final shapeBorderType = extractShapeBorderType(third);
      if (first == 'colors' &&
          second.length == 6 &&
          second.isHexColor() &&
          shapeBorderType != null) {
        return MyAppConfiguration.shapeBorder(second, shapeBorderType);
      } else {
        return MyAppConfiguration.unknown();
      }
    } else {
      return MyAppConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(MyAppConfiguration configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(location: '/unknown');
    } else if (configuration.isSplashPage) {
      return null;
    } else if (configuration.isLoginPage) {
      return RouteInformation(location: '/login');
    } else if (configuration.isHomePage) {
      return RouteInformation(location: '/');
    } else if (configuration.isColorPage) {
      return RouteInformation(location: '/colors/${configuration.colorCode}');
    } else if (configuration.isShapePage) {
      return RouteInformation(
          location:
              '/colors/${configuration.colorCode}/${configuration.shapeBorderType?.stringRepresentation()}');
    } else {
      return null;
    }
  }

  ShapeBorderType? extractShapeBorderType(String shapeBorderTypeValue) {
    final value = shapeBorderTypeValue.toLowerCase();
    switch (value) {
      case CONTINUOUS_SHAPE:
        return ShapeBorderType.CONTINUOUS;
      case BEVELED_SHAPE:
        return ShapeBorderType.BEVELED;
      case ROUNDED_SHAPE:
        return ShapeBorderType.ROUNDED;
      case STADIUM_SHAPE:
        return ShapeBorderType.STADIUM;
      case CIRCLE_SHAPE:
        return ShapeBorderType.CIRCLE;
      default:
        return null;
    }
  }
}
