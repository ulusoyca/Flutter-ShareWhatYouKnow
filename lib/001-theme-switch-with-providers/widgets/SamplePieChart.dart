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
import 'package:ulusoyapps_flutter/widgets/LegendTextWithBullet.dart';

class SamplePieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    var supplementaryColors = themeViewModel.companyColors.supplementaryColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: SizedBox(
            height: 180,
            child: _pieChart(
              supplementaryColors,
              themeViewModel.primaryTextTheme,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: _legend(supplementaryColors),
          flex: 1,
        )
      ],
    );
  }

  Widget _legend(List<Color> supplementaryColors) {
    List<Widget> rows = [];
    supplementaryColors.asMap().forEach((index, e) {
      Widget widget = Padding(
        padding: const EdgeInsets.only(
          top: AppDimens.SIZE_SPACING_XS,
          bottom: AppDimens.SIZE_SPACING_XS,
          left: AppDimens.SIZE_SPACING_MEDIUM,
        ),
        child: LegendTextWithBullet('Item $index', supplementaryColors[index]),
      );
      rows.add(widget);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _pieChart(List<Color> supplementaryColors, TextTheme textTheme) {
    return PieChart(
      PieChartData(
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 25,
          sections: showingSections(supplementaryColors, textTheme)),
    );
  }

  List<PieChartSectionData> showingSections(List<Color> supplementaryColors, TextTheme textTheme) {
    double radius = 50;
    return List.generate(5, (i) {
      return PieChartSectionData(
        color: supplementaryColors[i],
        value: 20,
        title: '20%',
        radius: radius,
        titleStyle: textTheme.caption,
      );
    });
  }
}
