import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/pages/meme_bottom_sheet_first_page_content.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/pages/meme_bottom_sheet_second_page_content.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/pages/meme_bottom_sheet_third_page_content.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_page.dart';

final _pageIndexNotifier = ValueNotifier(0);
final _selectedMemeIndex = ValueNotifier(0);
final _topText = ValueNotifier("");
final _bottomText = ValueNotifier("");

bool get _bothTextFieldsEmpty => _topText.value.isEmpty && _bottomText.value.isEmpty;

showMemeGeneratorBottomSheet(BuildContext context) {
  showScrollableBottomSheet(
    context: context,
    pageIndexListenable: _pageIndexNotifier,
    pages: (_) => [
      _firstPage(context),
      _secondPage(context),
      _thirdPage(context),
    ],
  );
}

ScrollableBottomSheetPage _firstPage(BuildContext context) {
  return ScrollableBottomSheetPage(
    title: Text(
      "Select Meme",
      style: _titleTextStyle(context),
    ),
    appbarTitle: "Select Meme",
    content: MemeBottomSheetFirstPageContent(
      selectedImageIndex: _selectedMemeIndex,
      pageIndexNotifier: _pageIndexNotifier,
    ),
    onClosePressed: () {
      _setToDefault();
      Navigator.maybePop(context);
    },
  );
}

ScrollableBottomSheetPage _secondPage(BuildContext context) {
  final primaryButtonEnabled = ValueNotifier(!_bothTextFieldsEmpty);
  Listenable.merge([_topText, _bottomText]).addListener(() {
    primaryButtonEnabled.value = !_bothTextFieldsEmpty;
  });
  return ScrollableBottomSheetPage(
    title: Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        "Add your text",
        style: _titleTextStyle(context),
      ),
    ),
    appbarTitle: "Add your text",
    headerHeight: 250,
    header: ValueListenableBuilder(
      valueListenable: _selectedMemeIndex,
      builder: (BuildContext context, value, Widget? child) {
        return Image(
          image: AssetImage('assets/cats_meme_${_selectedMemeIndex.value}.png'),
          fit: BoxFit.cover,
        );
      },
    ),
    content: MemeBottomSheetSecondPageContent(
      selectedImageIndex: _selectedMemeIndex,
      pageIndexNotifier: _pageIndexNotifier,
      topText: _topText,
      bottomText: _bottomText,
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

ScrollableBottomSheetPage _thirdPage(BuildContext context) {
  final primaryButtonState = ValueNotifier(PrimaryButtonState.idle);
  return ScrollableBottomSheetPage(
    title: Text(
      "Share the love",
      style: _titleTextStyle(context),
    ),
    appbarTitle: "Share the love",
    content: MemeBottomSheetThirdPageContent(
      selectedImageIndex: _selectedMemeIndex,
      pageIndexNotifier: _pageIndexNotifier,
      topText: _topText,
      bottomText: _bottomText,
    ),
    actionListenable: ValueNotifier(() {
      primaryButtonState.value = PrimaryButtonState.loading;
      Future.delayed(Duration(seconds: 2)).then(
        (_) {
          _setToDefault();
          Navigator.maybePop(context);
        },
      );
    }),
    actionTextListenable: ValueNotifier("Save to Camera Roll"),
    actionButtonStateListenable: primaryButtonState,
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
