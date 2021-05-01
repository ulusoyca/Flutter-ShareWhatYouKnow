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
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

import 'single_page_app_configuration_03.dart';

class SinglePageAppRouteInformationParser extends RouteInformationParser<MyAppConfiguration> {
  final List<Color> colors;

  SinglePageAppRouteInformationParser({this.colors});

  @override
  Future<MyAppConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    if (uri.pathSegments.length == 0) {
      return MyAppConfiguration.home();
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'colors' && _isValidColor(second)) {
        print("selectedColorCode: $second / colorCodeFromBrowserHistory: ${routeInformation.state}");
        return MyAppConfiguration.home(
          selectedColorCode: second,
          colorCodeFromBrowserHistory: routeInformation.state,
        );
      } else {
        return MyAppConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 3) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final third = uri.pathSegments[2].toLowerCase();
      final shapeBorderType = extractShapeBorderType(third);
      if (first == 'colors' && second.length == 6 && second.isHexColor() && shapeBorderType != null) {
        return MyAppConfiguration.shapeBorder(second, shapeBorderType);
      } else {
        return MyAppConfiguration.unknown();
      }
    } else {
      return MyAppConfiguration.unknown();
    }
  }

  @override
  RouteInformation restoreRouteInformation(MyAppConfiguration configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(location: '/unknown');
    } else if (configuration.isHomePage) {
      return RouteInformation(
        location: configuration.selectedColorCode == null ? '/' : '/colors/${configuration.selectedColorCode}',
        state: configuration.selectedColorCode,
      );
    } else if (configuration.isShapePage) {
      var location =
          '/colors/${configuration.selectedColorCode}/${configuration.shapeBorderType.getStringRepresentation()}';
      return RouteInformation(location: location);
    } else {
      return null;
    }
  }

  bool _isValidColor(String colorCode) {
    final List<String> colorCodes = colors.map((e) {
      return e.toHex();
    }).toList();
    return colorCodes.contains("$colorCode");
  }

  ShapeBorderType extractShapeBorderType(String shapeBorderTypeValue) {
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
