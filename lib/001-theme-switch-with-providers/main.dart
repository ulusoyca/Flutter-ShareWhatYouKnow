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
import 'package:ulusoyapps_flutter/001-theme-switch-with-providers/widgets/SampleBarChart.dart';
import 'package:ulusoyapps_flutter/001-theme-switch-with-providers/widgets/SamplePieChart.dart';
import 'package:ulusoyapps_flutter/cache/Preference.dart';
import 'package:ulusoyapps_flutter/resources/colors/app_colors.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
import 'package:ulusoyapps_flutter/resources/icon/company_icons.dart';
import 'package:ulusoyapps_flutter/resources/strings/app_strings.dart';
import 'package:ulusoyapps_flutter/resources/themes/company_name.dart';
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
    final themeViewModel = context.watch<ThemeViewModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeViewModel.currentTheme.themeData,
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
    final onPrimaryColor = themeViewModel.colors.colorScheme.onPrimary;
    final icons = themeViewModel.icons;
    return Scaffold(
      appBar: _appBar(themeViewModel, onPrimaryColor),
      bottomNavigationBar: _bottomAppBar(icons, onPrimaryColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _companySelection(themeViewModel),
              _clickNumber(themeViewModel),
              Divider(),
              _pieChart(),
              Divider(),
              _barChart(),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingButton(icons), // This
    );
  }

  Widget _pieChart() => SizedBox(
        height: 180,
        child: SamplePieChart(),
      );

  Widget _barChart() => Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_SPACING_LARGE),
        child: SizedBox(
          height: 180,
          child: SampleBarChart(),
        ),
      );

  Widget _companySelection(ThemeViewModel themeViewModel) {
    return Material(
      shape: themeViewModel.shapes.toggleButtonShapeBorder,
      elevation: 2.0,
      type: MaterialType.canvas,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ToggleButtons(
        children: [
          _toggleButtonChild(AppStrings.COMPANY_ATA),
          _toggleButtonChild(AppStrings.COMPANY_BIOHACK),
          _toggleButtonChild(AppStrings.COMPANY_CODELAND),
        ],
        onPressed: (int index) {
          switch (index) {
            case 0:
              themeViewModel.updateCompany(CompanyName.ATA);
              break;
            case 1:
              themeViewModel.updateCompany(CompanyName.BIOHACK);
              break;
            case 2:
              themeViewModel.updateCompany(CompanyName.CODELAND);
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
      ),
    );
  }

  BottomAppBar _bottomAppBar(CompanyIcons icons, Color onPrimaryColor) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(icons.menu),
            color: onPrimaryColor,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(icons.search),
            color: onPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  AppBar _appBar(ThemeViewModel themeViewModel, Color onPrimaryColor) {
    var icons = themeViewModel.icons;
    return AppBar(
      brightness: themeViewModel.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      actions: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_MEDIUM),
            child: Icon(
              themeViewModel.brightness == Brightness.dark ? icons.lightBulbOff : icons.lightBulbOn,
              color: onPrimaryColor,
            ),
          ),
          onTap: () {
            themeViewModel.toggleBrightness();
          },
        ),
      ],
      backgroundColor: themeViewModel.colors.colorScheme.primary,
      title: Text(
        widget.title,
        style: themeViewModel.baseTextTheme.headline6.copyWith(color: onPrimaryColor),
      ),
      //act
    );
  }

  Widget _toggleButtonChild(String text) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_LARGE),
        child: Text(text),
      );

  Widget _clickNumber(ThemeViewModel themeViewModel) {
    return Padding(
      padding: EdgeInsets.only(top: AppDimens.SIZE_SPACING_XL),
      child: Column(
        children: [
          Text(
            AppStrings.PUSH_MESSAGE,
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
              child: Text(AppStrings.RESET_COUNTER),
              onPressed: _resetCounter,
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton _floatingButton(CompanyIcons icons) {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: AppStrings.INCREMENT,
      child: Icon(icons.add),
    );
  }

  Color _getCounterColor(ThemeViewModel themeViewModel) {
    AlertLevels alertLevels = themeViewModel.colors.alertLevels;
    if (_counter == 0) {
      return alertLevels.neutral;
    } else if (_counter < 5) {
      return alertLevels.safe;
    } else if (_counter < 10) {
      return alertLevels.warning;
    } else {
      return alertLevels.alert;
    }
  }
}
