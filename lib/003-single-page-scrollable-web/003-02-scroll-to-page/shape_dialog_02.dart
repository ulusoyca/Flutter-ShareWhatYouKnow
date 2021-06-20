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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/app_bar_text.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shaped_container.dart';
import 'package:ulusoyapps_flutter/003-single-page-scrollable-web/widgets/app_bar_back_button.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class ShapeDialog extends StatelessWidget {
  final String colorCode;
  final ShapeBorderType shapeBorderType;

  const ShapeDialog({
    Key key,
    this.colorCode,
    this.shapeBorderType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderType = shapeBorderType.getStringRepresentation().toUpperCase();
    return Center(
      child: Container(
        width: 400,
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            _bar(borderType),
            Expanded(
              child: _button(context, borderType),
            ),
          ],
        ),
      ),
    );
  }

  Padding _button(BuildContext context, String borderType) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: FittedBox(
        child: ShapedButton(
          color: colorCode.hexToColor(),
          shapeBorderType: shapeBorderType,
          text: "Submit",
          onPressed: () => print("Submit clicked"),
        ),
      ),
    );
  }

  AppBar _bar(String borderType) {
    final color = colorCode.hexToColor();
    return AppBar(
      title: AppBarText(
        color: color,
        text: '$borderType #$colorCode ',
      ),
      leading: AppBarBackButton(color: color),
      backgroundColor: color,
    );
  }
}
