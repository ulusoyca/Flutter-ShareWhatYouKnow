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
import 'package:ulusoyapps_flutter/resources/colors/app_colors.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/themes/theme_view_model.dart';

class SampleBarChart extends StatelessWidget {
  final data = List.generate(20, (_) => Random().nextInt(50));

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    return _barGraph(themeViewModel);
  }

  Widget _barGraph(ThemeViewModel themeViewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: _barChart(
          themeViewModel.companyColors.heatmapColors,
          themeViewModel.companyShapes.barGraphShapeBorder,
        ),
      ),
    );
  }

  Widget _barChart(HeatmapColors heatmapColors, ShapeBorder shapeBorder) {
    final maxValue = data.reduce(max);
    final minValue = data.reduce(min);
    final List<Widget> columns = [];
    for (int index = 0; index < data.length; index++) {
      var weight = (data[index] - minValue) / (maxValue - minValue);
      var color = heatmapColors.getColor(weight);
      columns.add(
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                flex: _calculateFlex(1.0 - weight),
                child: Container(),
              ),
              Expanded(
                flex: _calculateFlex(weight),
                child: Material(
                  shape: shapeBorder,
                  color: color,
                  type: MaterialType.canvas,
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      height: 100,
      child: Row(
        children: columns,
      ),
    );
  }

  int _calculateFlex(double weight) => (weight * 100).round();
}
