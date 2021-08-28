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
import 'package:theme_switch_with_provider/resources/colors/app_colors.dart';
import 'package:theme_switch_with_provider/resources/strings/app_strings.dart';

class ClickCounter extends StatefulWidget {
  final TextStyle textStyle;
  final AlertLevels alertLevels;
  final ValueNotifier<int> clickCounterNotifier;

  const ClickCounter({
    Key? key,
    required this.textStyle,
    required this.alertLevels,
    required this.clickCounterNotifier,
  }) : super(key: key);

  @override
  _ClickCounterState createState() => _ClickCounterState();
}

class _ClickCounterState extends State<ClickCounter> {
  Color get _counterColor {
    final counter = widget.clickCounterNotifier.value;
    if (counter == 0) {
      return widget.alertLevels.neutral;
    } else if (counter < 5) {
      return widget.alertLevels.safe;
    } else if (counter < 10) {
      return widget.alertLevels.warning;
    } else {
      return widget.alertLevels.alert;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.clickCounterNotifier,
      builder: (BuildContext context, int value, Widget? child) {
        return Column(
          children: [
            Text(AppStrings.PUSH_MESSAGE),
            Text('$value', style: widget.textStyle.copyWith(color: _counterColor)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_SPACING_SMALL),
              child: RaisedButton(
                child: Text(AppStrings.RESET_COUNTER),
                onPressed: () {
                  setState(() {
                    widget.clickCounterNotifier.value = 0;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
