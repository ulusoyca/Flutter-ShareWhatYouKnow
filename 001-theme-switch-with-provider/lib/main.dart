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

import 'package:common/cache/preference.dart';
import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_switch_with_provider/resources/strings/app_strings.dart';
import 'package:theme_switch_with_provider/resources/themes/theme_view_model.dart';
import 'package:theme_switch_with_provider/widgets/click_counter.dart';
import 'package:theme_switch_with_provider/widgets/company_selection.dart';
import 'package:theme_switch_with_provider/widgets/sample_bar_chart.dart';
import 'package:theme_switch_with_provider/widgets/sample_pie_chart.dart';
import 'package:theme_switch_with_provider/widgets/theme_switch_bottom_app_bar.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final clickCounterNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseTextTheme = themeViewModel.baseTextTheme;
    final onPrimaryColor = themeViewModel.colors.colorScheme.onPrimary;
    final brightness = themeViewModel.brightness;
    final shapes = themeViewModel.shapes;
    final icons = themeViewModel.icons;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_MEDIUM),
              child: Icon(
                brightness == Brightness.dark ? icons.lightBulbOff : icons.lightBulbOn,
                color: onPrimaryColor,
              ),
            ),
            onTap: themeViewModel.toggleBrightness,
          ),
        ],
        backgroundColor: themeViewModel.colors.colorScheme.primary,
        title: Text(
          '001 Theme Switch',
          style: baseTextTheme.headline6!.copyWith(color: onPrimaryColor),
        ),
      ),
      bottomNavigationBar: ThemeSwitchBottomAppBar(icons: icons, onPrimaryColor: onPrimaryColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CompanySelection(
                toggleButtonShapeBorder: shapes.toggleButtonShapeBorder,
                onCompanySelected: (companyName) => themeViewModel.updateCompany(companyName),
              ),
              SizedBox(height: AppDimens.SIZE_SPACING_LARGE),
              ClickCounter(
                clickCounterNotifier: clickCounterNotifier,
                textStyle: themeViewModel.baseTextTheme.headline4!,
                alertLevels: themeViewModel.colors.alertLevels,
              ),
              Divider(),
              SizedBox(height: 180, child: SamplePieChart()),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_SPACING_LARGE),
                child: SizedBox(height: 180, child: SampleBarChart()),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => clickCounterNotifier.value = clickCounterNotifier.value + 1,
        tooltip: AppStrings.INCREMENT,
        child: Icon(icons.add),
      ), // This
    );
  }
}
