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

import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_switch_with_provider/resources/colors/company_colors.dart';
import 'package:theme_switch_with_provider/resources/shape/company_shapes.dart';
import 'package:theme_switch_with_provider/resources/themes/theme_view_model.dart';
import 'package:theme_switch_with_provider/widgets/bar_chart_legend.dart';

class SampleBarChart extends StatelessWidget {
  final data = List.generate(20, (_) => Random().nextInt(50));

  static const int _numberOfLegendBoxes = 7;

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final colors = themeViewModel.colors;
    final textTheme = themeViewModel.baseTextTheme;
    final shapes = themeViewModel.shapes;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: Column(
          children: [
            _barChart(colors, shapes),
            SizedBox(height: AppDimens.SIZE_SPACING_MEDIUM),
            BarChartLegend(
              textTheme: textTheme,
              colors: colors,
              shapes: shapes,
              numberOfLegendBoxes: _numberOfLegendBoxes,
            )
          ],
        ),
      ),
    );
  }

  Widget _barChart(CompanyColors? companyColors, CompanyShapes? companyShapes) {
    final maxValue = data.reduce(max);
    final minValue = data.reduce(min);
    final List<Widget> columns = [];
    for (int index = 0; index < data.length; index++) {
      /// Calculate weight between 0 and 1
      final weight = (data[index] - minValue) / (maxValue - minValue);

      /// Linear interpolate between two HSVColors based on weight
      final color = companyColors!.heatmapColors.getColor(weight);
      columns.add(
        Expanded(
          child: Column(
            children: [
              Flexible(
                flex: ((1.0 - weight) * 100).round(),
                child: Container(), // Empty transparent container from top to value
              ),
              Flexible(
                flex: (weight * 100).round(),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: companyShapes!.barGraphShapeBorder,
                    color: color,
                  ),
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
}
