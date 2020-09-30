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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ulusoyapps_flutter/cache/Preference.dart';
import 'package:ulusoyapps_flutter/extensions/build_context_extensions.dart';
import 'package:ulusoyapps_flutter/resources/colors/app_colors.dart';
import 'package:ulusoyapps_flutter/resources/dimens/app_dimens.dart';
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
    return Scaffold(
      appBar: AppBar(
        brightness: context.brightness,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_MEDIUM),
              child: Icon(
                themeViewModel.brightness == Brightness.dark
                    ? MdiIcons.lightbulbOffOutline
                    : MdiIcons.lightbulbOnOutline,
                color: themeViewModel.appColors.colorScheme.onSurface,
              ),
            ),
            onTap: () {
              themeViewModel.toggleBrightness();
            },
          ),
        ],
        title: Text(widget.title),
        //actions: [Icon()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: themeViewModel.baseTextTheme.headline4.copyWith(color: _getCounterColor(themeViewModel)),
              ),
              AspectRatio(
                aspectRatio: 2.0,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
                    child: _barChart(themeViewModel),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Reset Counter'),
                onPressed: _resetCounter,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This
    );
  }

  BarChart _barChart(ThemeViewModel themeViewModel) {
    var graphColors = themeViewModel.appColors.graphColors;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: themeViewModel.baseTextTheme.caption,
            margin: 20,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Below';
                case 1:
                  return 'On Target';
                case 2:
                  return 'Above';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 5, color: graphColors.belowTarget)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 10, color: graphColors.onTarget)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 14, color: graphColors.aboveTarget)]),
        ],
      ),
    );
  }

  /// This is bad but here only for demonstration purposes.
  /// View should not contain any logic. The logic should be in view model.
  Color _getCounterColor(ThemeViewModel themeViewModel) {
    AlertLevels alertLevels = themeViewModel.appColors.alertLevels;
    if (_counter < 5) {
      return alertLevels.neutral;
    } else if (_counter < 10) {
      return alertLevels.warning;
    } else {
      return alertLevels.alert;
    }
  }
}
