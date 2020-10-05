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
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/001-theme-switch-with-providers/widgets/SampleBarChart.dart';
import 'package:ulusoyapps_flutter/001-theme-switch-with-providers/widgets/SamplePieChart.dart';
import 'package:ulusoyapps_flutter/cache/Preference.dart';
import 'package:ulusoyapps_flutter/extensions/build_context_extensions.dart';
import 'package:ulusoyapps_flutter/resources/colors/alert_level_colors.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/themes/companies.dart';
import 'package:ulusoyapps_flutter/resources/themes/theme_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Preference _preference = Preference();
  runApp(
    ChangeNotifierProvider<ThemeViewModel>(
      create: (context) => ThemeViewModel(_preference),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.appThemeData,
      home: MyHomePage(title: '001 Theme Switch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<bool> _isSelected = [true, false, false];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    var onPrimaryColor = themeViewModel.companyColors.colorScheme.onPrimary;
    return Scaffold(
      appBar: _appBar(themeViewModel, onPrimaryColor),
      bottomNavigationBar: _bottomAppBar(onPrimaryColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _companySelection(themeViewModel),
              _clickNumber(themeViewModel),
              Divider(),
              SamplePieChart(),
              Divider(),
              _barChart(),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingButton(), // This
    );
  }

  Widget _barChart() => Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_SPACING_LARGE),
        child: SampleBarChart(),
      );

  ToggleButtons _companySelection(ThemeViewModel themeViewModel) {
    return ToggleButtons(
      children: <Widget>[
        toggleButtonChild('Company A'),
        toggleButtonChild('Company B'),
        toggleButtonChild('Company C'),
      ],
      onPressed: (int index) {
        switch (index) {
          case 0:
            themeViewModel.updateCompany(Company.COMPANY_A);
            break;
          case 1:
            themeViewModel.updateCompany(Company.COMPANY_B);
            break;
          case 2:
            themeViewModel.updateCompany(Company.COMPANY_C);
            break;
        }
        setState(() {
          for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
            if (buttonIndex == index) {
              _isSelected[buttonIndex] = true;
            } else {
              _isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: _isSelected,
    );
  }

  BottomAppBar _bottomAppBar(Color onPrimaryColor) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            color: onPrimaryColor,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: onPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  AppBar _appBar(ThemeViewModel themeViewModel, Color onPrimaryColor) {
    return AppBar(
      brightness: themeViewModel.brightness,
      actions: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_MEDIUM),
            child: Icon(
              themeViewModel.brightness == Brightness.dark ? MdiIcons.lightbulbOffOutline : MdiIcons.lightbulbOnOutline,
              color: onPrimaryColor,
            ),
          ),
          onTap: () {
            themeViewModel.toggleBrightness();
          },
        ),
      ],
      title: Text(
        widget.title,
        style: themeViewModel.baseTextTheme.headline6.copyWith(color: onPrimaryColor),
      ),
      //act
    );
  }

  Widget toggleButtonChild(String text) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_SMALL),
        child: Text(text),
      );

  Widget _clickNumber(ThemeViewModel themeViewModel) {
    return Padding(
      padding: EdgeInsets.only(top: AppDimens.SIZE_SPACING_XL),
      child: Column(
        children: [
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: themeViewModel.baseTextTheme.headline4.copyWith(color: _getCounterColor(themeViewModel)),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: AppDimens.SIZE_SPACING_SMALL,
              bottom: AppDimens.SIZE_SPACING_LARGE,
            ),
            child: RaisedButton(
              child: Text('Reset Counter'),
              onPressed: _resetCounter,
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }

  /// This is bad but here only for demonstration purposes.
  /// View should not contain any logic. The logic should be in view model.
  Color _getCounterColor(ThemeViewModel themeViewModel) {
    AlertLevels alertLevels = themeViewModel.companyColors.alertLevels;
    if (_counter < 5) {
      return alertLevels.neutral;
    } else if (_counter < 10) {
      return alertLevels.warning;
    } else {
      return alertLevels.alert;
    }
  }
}
