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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_2/widgets/color_gridview.dart';

class HomeScreen extends StatelessWidget {
  final Function(String) onColorTap;
  final List<Color> colors = Colors.primaries.reversed.toList();

  HomeScreen({Key? key, required this.onColorTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: ColorGrid(
        colors: Colors.primaries.reversed.toList(),
        onColorTap: onColorTap,
      ),
    );
  }
}
