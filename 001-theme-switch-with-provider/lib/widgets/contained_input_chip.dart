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
import 'package:theme_switch_with_provider/resources/themes/theme_view_model.dart';

class ContainedInputChip extends StatelessWidget {
  final String labelText;
  final MaterialColor color;

  const ContainedInputChip({required this.labelText, required this.color});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final backgroundColor = themeViewModel.isDark ? color.shade200 : color.shade500;
    return RawChip(
      backgroundColor: backgroundColor,
      label: Text(
        labelText,
        maxLines: 2,
        style: themeViewModel.primaryTextTheme.caption,
      ),
    );
  }
}
