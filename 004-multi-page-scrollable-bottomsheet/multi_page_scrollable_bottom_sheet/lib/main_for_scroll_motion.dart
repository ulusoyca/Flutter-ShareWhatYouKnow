import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_page_scrollable_bottom_sheet/home_screen.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/themes/text_theme/app_text_theme.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/pages_for_scroll_motion/meme_bottom_sheet_pages_scroll_motion.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTextTheme.buildTextTheme(),
      ),
      home: HomeScreen(
        showScrollableBottomSheet: showMemeGeneratorBottomSheetForScrollMotion,
      ),
    );
  }
}
