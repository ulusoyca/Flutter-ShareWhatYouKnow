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

import 'package:common/dimens/app_dimens.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_switch_with_provider/resources/themes/theme_view_model.dart';
import 'package:theme_switch_with_provider/widgets/pie_chart_legend.dart';

class SamplePieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final companyColors = themeViewModel.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: _pieChart(companyColors.supplementaryColors, themeViewModel.primaryTextTheme),
        ),
        SizedBox(width: AppDimens.SIZE_SPACING_MEDIUM),
        Flexible(
          flex: 2,
          child: PieChartLegend(supplementaryColors: companyColors.supplementaryAccentColors),
        )
      ],
    );
  }

  Widget _pieChart(List<Color> supplementaryColors, TextTheme? textTheme) {
    return PieChart(
      PieChartData(
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: AppDimens.SIZE_SPACING_MEDIUM,
        sections: List.generate(
          5,
          (i) => PieChartSectionData(
            color: supplementaryColors[i],
            value: 20,
            title: '20%',
            radius: 50,
            titleStyle: textTheme!.caption,
          ),
        ),
      ),
    );
  }
}
