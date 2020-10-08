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
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/themes/theme_view_model.dart';

class LegendTextWithBullet extends StatelessWidget {
  final String text;
  final Color bulletColor;

  LegendTextWithBullet(this.text, this.bulletColor);

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: AppDimens.SIZE_SPACING_SMALL),
          child: Material(
            type: MaterialType.canvas,
            shape: themeViewModel.themeData.materialShapeBorder,
            color: bulletColor,
            child: Container(
              width: AppDimens.SIZE_SPACING_MEDIUM,
              height: AppDimens.SIZE_SPACING_MEDIUM,
              decoration: BoxDecoration(
                borderRadius: themeViewModel.themeData.borderRadius,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            softWrap: false,
            maxLines: 1,
            style: themeViewModel.baseTextTheme.subtitle1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
