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

import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:common/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:navigator_2/002-02-mobile-only-with-auth/widgets/logout_fab_02.dart';
import 'package:navigator_2/002-04-mobile-and-web-with-auth-and-bootstrap/widgets/app_bar_back_button.dart';
import 'package:navigator_2/viewmodels/auth_view_model.dart';
import 'package:navigator_2/widgets/in_progress_message.dart';
import 'package:navigator_2/widgets/shape_border_gridview.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatelessWidget {
  final String colorCode;
  final Function(ShapeBorderType) onShapeTap;
  final VoidCallback onLogout;

  Color get color => colorCode.hexToColor();

  const ColorScreen({
    Key? key,
    required this.colorCode,
    required this.onShapeTap,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LogoutFab(onLogout: onLogout, color: color),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: AppBarText(appBarColor: color, text: '#$colorCode'),
      backgroundColor: color,
      leading: AppBarBackButton(color: color),
      brightness: ThemeData.estimateBrightnessForColor(color),
    );
  }

  Widget _body(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return authViewModel.logingOut
        ? InProgressMessage(progressName: "Logout", screenName: "ColorScreen")
        : ShapeBorderGridView(
            color: color,
            onShapeTap: onShapeTap,
          );
  }
}
