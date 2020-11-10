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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/resources/colors/company_colors.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/shape/company_shapes.dart';
import 'package:ulusoyapps_flutter/resources/strings/app_strings.dart';
import 'package:ulusoyapps_flutter/resources/themes/theme_view_model.dart';

class SampleBarChart extends StatelessWidget {
  final data = List.generate(20, (_) => Random().nextInt(50));

  static const int NUMBER_OF_LEGEND_BOXES = 7;

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    return _barGraph(themeViewModel);
  }

  Widget _barGraph(ThemeViewModel themeViewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: Column(
          children: [
            _barChart(
              themeViewModel.colors,
              themeViewModel.shapes,
            ),
            SizedBox(height: AppDimens.SIZE_SPACING_MEDIUM),
            _legend(
              themeViewModel.baseTextTheme,
              themeViewModel.colors,
              themeViewModel.shapes.legendBoxShapeBorder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _barChart(CompanyColors companyColors, CompanyShapes companyShapes) {
    final maxValue = data.reduce(max);
    final minValue = data.reduce(min);
    final List<Widget> columns = [];
    for (int index = 0; index < data.length; index++) {
      final weight = (data[index] - minValue) / (maxValue - minValue); // Calculate weight between 0 and 1
      final color =
          companyColors.heatmapColors.getColor(weight); // Linear interpolate between two HSVColors based on weight
      columns.add(
        Expanded(
          child: Column(
            children: [
              Flexible(
                flex: _calculateFlex(1.0 - weight),
                child: Container(), // Empty transparent container from top to value
              ),
              Flexible(
                flex: _calculateFlex(weight),
                child: Container(
                  // Decorated container from bottom to value
                  decoration: ShapeDecoration(shape: companyShapes.barGraphShapeBorder, color: color),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      height: 100,
      child: Row(children: columns),
    );
  }

  int _calculateFlex(double weight) => (weight * 100).round();

  Widget _legend(
    TextTheme textTheme,
    CompanyColors companyColors,
    ShapeBorder shapeBorder,
  ) {
    final List<Widget> columns = [];
    columns.add(_textLegend(AppStrings.MIN, textTheme, TextAlign.start));
    for (int index = 0; index <= NUMBER_OF_LEGEND_BOXES; index++) {
      columns.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_2XS),
            child: Container(
              height: AppDimens.SIZE_SPACING_SM,
              decoration: ShapeDecoration(
                shape: shapeBorder,
                color: companyColors.heatmapColors.getColor(index / NUMBER_OF_LEGEND_BOXES),
              ),
            ),
          ),
        ),
      );
    }
    columns.add(_textLegend(AppStrings.MAX, textTheme, TextAlign.end));
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: columns,
    );
  }

  Widget _textLegend(String text, TextTheme textTheme, TextAlign textAlignment) {
    return SizedBox(
      width: AppDimens.SIZE_SPACING_2XL,
      child: Text(
        text,
        style: textTheme.caption,
        textAlign: textAlignment,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
