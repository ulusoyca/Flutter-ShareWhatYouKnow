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
import 'package:flutter/material.dart';
import 'package:theme_switch_with_provider/resources/colors/company_colors.dart';
import 'package:theme_switch_with_provider/resources/shape/company_shapes.dart';
import 'package:theme_switch_with_provider/resources/strings/app_strings.dart';

class BarChartLegend extends StatelessWidget {
  final TextTheme textTheme;
  final CompanyColors colors;
  final CompanyShapes shapes;
  final int numberOfLegendBoxes;

  const BarChartLegend({
    Key? key,
    required this.textTheme,
    required this.colors,
    required this.shapes,
    required this.numberOfLegendBoxes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> columns = [];
    columns.add(_textLegend(AppStrings.MIN, textTheme, TextAlign.start));
    for (int index = 0; index <= numberOfLegendBoxes; index++) {
      columns.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_2XS),
            child: Container(
              height: AppDimens.SIZE_SPACING_SM,
              decoration: ShapeDecoration(
                shape: shapes.legendBoxShapeBorder,
                color: colors.heatmapColors.getColor(index / numberOfLegendBoxes),
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
