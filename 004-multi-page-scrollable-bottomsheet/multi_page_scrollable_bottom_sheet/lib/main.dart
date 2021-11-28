import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/themes/text_theme/app_text_theme.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/circular_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/pages/meme_bottom_sheet_pages.dart';

void main() {
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularButton(iconData: Icons.menu_rounded),
                  Expanded(
                      child: Text(
                    "MemeTastic",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  )),
                  CircularButton(iconData: Icons.add_rounded),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/home_meme_1.png'),
                      Image.asset('assets/home_meme_2.png'),
                    ],
                  ),
                  Expanded(child: Image.asset('assets/home_meme_3.png')),
                  Column(
                    children: [
                      Image.asset('assets/home_meme_4.png'),
                      Image.asset('assets/home_meme_5.png'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  Text(
                    "Create a meme",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text("Select an image, add a caption, and share your creation with the world",
                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: 24),
                  PrimaryButton(
                    text: "Generate",
                    colorName: AppColorNames.blue,
                    onPressed: () => showMemeGeneratorBottomSheet(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
