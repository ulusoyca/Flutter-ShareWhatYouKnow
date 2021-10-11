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
import 'package:single_page_scrollable_website/003-05-query-params/router/single_page_app_configuration_05.dart';

class SinglePageAppRouteInformationParser
    extends RouteInformationParser<SinglePageAppConfiguration> {
  final List<MaterialColor> colors;

  SinglePageAppRouteInformationParser({required this.colors});

  @override
  Future<SinglePageAppConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.length == 0) {
      return SinglePageAppConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == "section" && uri.query.isNotEmpty) {
        final queryParams = uri.queryParameters;
        final color = queryParams["color"];
        final borderType = queryParams["borderType"];
        if (borderType == null && color != null && _isValidColor(color)) {
          return SinglePageAppConfiguration.home(color);
        } else if (borderType != null &&
            extractShapeBorderType(borderType) != null &&
            color != null &&
            _isValidColor(color)) {
          return SinglePageAppConfiguration.home(color, extractShapeBorderType(borderType));
        }
      }
    }
    return SinglePageAppConfiguration.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(SinglePageAppConfiguration configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(location: '/unknown');
    } else {
      final colorCode = configuration.colorCode;
      if (colorCode == null) {
        return RouteInformation(location: '/');
      } else if (configuration.shapeBorderType == null) {
        return RouteInformation(location: '/section?color=$colorCode');
      } else {
        final shapeBorderType = configuration.shapeBorderType?.stringRepresentation();
        return RouteInformation(location: '/section?color=$colorCode&borderType=$shapeBorderType');
      }
    }
  }

  bool _isValidColor(String colorCode) {
    final List<String> colorCodes = colors.map((e) {
      return e.toHex();
    }).toList();
    return colorCodes.contains("$colorCode");
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
