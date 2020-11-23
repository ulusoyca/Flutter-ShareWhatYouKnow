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
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/widgets/app_bar_back_button.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/002-04-mobile-and-web-with-auth-and-bootstrap/widgets/logout_fab_04.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/entity/shape_border_type.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/viewmodels/auth_view_model.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/viewmodels/colors_view_model.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/app_bar_text.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/in_progress_message.dart';
import 'package:ulusoyapps_flutter/002-navigator-2/widgets/shape_border_gridview.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatelessWidget {
  final String colorCode;
  final Function(ShapeBorderType) onShapeTap;
  final VoidCallback onLogout;

  Color get color => colorCode.hexToColor();

  const ColorScreen({
    Key key,
    @required this.colorCode,
    @required this.onShapeTap,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(color: color, text: '#$colorCode'),
        backgroundColor: colorCode.hexToColor(),
        leading: AppBarBackButton(color: color),
      ),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LogoutFab(onLogout: onLogout, color: color),
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
    return inProgress
        ? InProgressMessage(
            progressName: progressName, screenName: "ColorScreen")
        : ShapeBorderGridView(
            color: color,
            onShapeTap: onShapeTap,
          );
  }
}
