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
import "package:provider/provider.dart";
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-05-web-with-route-state/widgets/logout_fab_05.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/viewmodels/auth_view_model.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/viewmodels/colors_view_model.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/color_gridview.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/in_progress_message.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shape_border_gridview.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class HomeScreen extends StatelessWidget {
  final Function(String) onColorTap;
  final List<Color> colors;
  final VoidCallback onLogout;
  final Function(ShapeBorderType) onShapeTap;
  final int startIndex;
  final ItemScrollController _itemScrollController = ItemScrollController();

  HomeScreen({
    Key key,
    @required this.onColorTap,
    @required this.onLogout,
    @required this.colors,
    @required this.onShapeTap,
    @required this.startIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LogoutFab(onLogout: onLogout),
    );
  }

  Widget _body(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final colorsViewModel = context.watch<ColorsViewModel>();
    bool inProgress;
    String progressName;
    if (authViewModel.logingOut) {
      inProgress = true;
      progressName = "Logout";
    } else if (colorsViewModel.clearingColors) {
      inProgress = true;
      progressName = "Clearing colors";
    } else {
      inProgress = false;
      progressName = null;
    }
    return inProgress ? InProgressMessage(progressName: progressName, screenName: "HomeScreen") : _content();
  }

  Widget _content() {
    return Column(
      children: [
        _colorGrid(),
        Expanded(child: _shapedColorList()),
      ],
    );
  }

  Widget _colorGrid() => Material(
        child: ColorGrid(
          colors: colors,
          onColorTap: (String value) {
            int index = _findIndexFromColorCode(value);
            _itemScrollController.scrollTo(
              index: index,
              duration: Duration(seconds: 2),
              curve: Curves.easeInOutCubic,
            );
            onColorTap(value);
          },
        ),
        elevation: 4.0,
      );

  Widget _shapedColorList() {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        final color = colors[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(color.toHex(leadingHashSign: true), style: Theme.of(context).textTheme.headline5),
              ShapeBorderGridView(
                color: color,
                onShapeTap: (ShapeBorderType type) {
                  onColorTap(color.toHex(leadingHashSign: false));
                  onShapeTap(type);
                },
                scrollPhysics: NeverScrollableScrollPhysics(),
              ),
              Divider(thickness: 2),
            ],
          ),
        );
      },
    );
  }

  int _findIndexFromColorCode(String value) {
    var indexWhere = colors.indexWhere((element) => element.toHex() == value);
    return indexWhere == -1 ? 0 : indexWhere;
  }
}
