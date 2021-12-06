import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/pages_for_scroll_motion/meme_bottom_sheet_page_without_hero.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_page.dart';

final _pageIndexNotifier = ValueNotifier(0);
final _selectedMemeIndex = ValueNotifier(0);
final _topText = ValueNotifier("");
final _bottomText = ValueNotifier("");

bool get _bothTextFieldsEmpty => _topText.value.isEmpty && _bottomText.value.isEmpty;

showMemeGeneratorBottomSheetForScrollMotion(BuildContext context) {
  showScrollableBottomSheet(
    context: context,
    pageIndexListenable: _pageIndexNotifier,
    pages: (_) => [
      _pageWithoutHero(context),
      _pageWithHero(context),
    ],
  );
}

ScrollableBottomSheetPage _pageWithoutHero(BuildContext context) {
  return ScrollableBottomSheetPage(
    title: Text(
      "Select Meme",
      style: _titleTextStyle(context),
    ),
    appbarTitle: "Select Meme",
    content: MemeBottomSheetPageWithoutHero(
      selectedImageIndex: _selectedMemeIndex,
      pageIndexNotifier: _pageIndexNotifier,
    ),
    onClosePressed: () {
      _setToDefault();
      Navigator.maybePop(context);
    },
  );
}

ScrollableBottomSheetPage _pageWithHero(BuildContext context) {
  final primaryButtonEnabled = ValueNotifier(!_bothTextFieldsEmpty);
  Listenable.merge([_topText, _bottomText]).addListener(() {
    primaryButtonEnabled.value = !_bothTextFieldsEmpty;
  });
  return ScrollableBottomSheetPage(
    title: Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        "Story of the cat",
        style: _titleTextStyle(context),
      ),
    ),
    heroImageHeight: 250,
    appbarTitle: "Story of the cat",
    heroImage: ValueListenableBuilder(
      valueListenable: _selectedMemeIndex,
      builder: (BuildContext context, value, Widget? child) {
        return Image(
          image: AssetImage('assets/cats_meme_${_selectedMemeIndex.value}.png'),
          fit: BoxFit.cover,
        );
      },
    ),
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        lorem(paragraphs: 4, words: 200),
        style: Theme.of(context).textTheme.subtitle1,
      ),
    ),
    actionListenable: ValueNotifier(() {
      _pageIndexNotifier.value = 2;
    }),
    actionEnabledListenable: primaryButtonEnabled,
    actionTextListenable: ValueNotifier("Generate"),
    onClosePressed: () {
      _setToDefault();
      Navigator.maybePop(context);
    },
  );
}

void _setToDefault() {
  _pageIndexNotifier.value = 0;
  _topText.value = "";
  _bottomText.value = "";
}

TextStyle _titleTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold);
