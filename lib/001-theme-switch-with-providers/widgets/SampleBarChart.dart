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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/themes/theme_view_model.dart';

class SampleBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    return _barGraph(themeViewModel);
  }

  AspectRatio _barGraph(ThemeViewModel themeViewModel) {
    return AspectRatio(
      aspectRatio: 2.1,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
          child: _barChart(themeViewModel),
        ),
      ),
    );
  }

  BarChart _barChart(ThemeViewModel themeViewModel) {
    var graphColors = themeViewModel.companyColors.graphColors;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: themeViewModel.baseTextTheme.caption,
            margin: 20,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Below';
                case 1:
                  return 'On Target';
                case 2:
                  return 'Above';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 5, color: graphColors.belowTarget)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 10, color: graphColors.onTarget)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 14, color: graphColors.aboveTarget)]),
        ],
      ),
    );
  }
}
