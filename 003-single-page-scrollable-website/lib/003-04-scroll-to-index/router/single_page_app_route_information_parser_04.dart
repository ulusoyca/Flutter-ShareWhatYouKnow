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
import 'package:single_page_scrollable_website/003-04-scroll-to-index/router/single_page_app_configuration_04.dart';

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
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'colors' && _isValidColor(second)) {
        return SinglePageAppConfiguration.home(colorCode: second);
      } else {
        return SinglePageAppConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 3) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final third = uri.pathSegments[2].toLowerCase();
      final shapeBorderType = extractShapeBorderType(third);
      if (first == 'colors' && shapeBorderType != null) {
        return SinglePageAppConfiguration.shapeBorder(
          second,
          shapeBorderType,
        );
      } else {
        return SinglePageAppConfiguration.unknown();
      }
    } else {
      return SinglePageAppConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(SinglePageAppConfiguration configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(location: '/unknown');
    } else if (configuration.isHomePage) {
      return RouteInformation(
        location: configuration.colorCode == null ? '/' : '/colors/${configuration.colorCode}',
      );
    } else if (configuration.isShapePage) {
      final borderType = configuration.shapeBorderType?.stringRepresentation();
      final location = '/colors/${configuration.colorCode}/$borderType';
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
