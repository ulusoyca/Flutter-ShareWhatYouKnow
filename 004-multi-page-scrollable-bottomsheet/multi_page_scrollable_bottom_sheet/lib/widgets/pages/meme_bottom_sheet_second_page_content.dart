import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/primary_button.dart';

class MemeBottomSheetSecondPageContent extends StatelessWidget {
  final ValueNotifier<int> selectedImageIndex;
  final ValueNotifier<int> pageIndexNotifier;
  final ValueNotifier<String> topText;
  final ValueNotifier<String> bottomText;

  const MemeBottomSheetSecondPageContent(
      {Key? key,
      required this.selectedImageIndex,
      required this.pageIndexNotifier,
      required this.topText,
      required this.bottomText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Bottom sheet subtitle goes here and is as long as it needs to be",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        _MemeInputText(labelText: "Top text", textNotifier: topText),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 40),
          child: _MemeInputText(labelText: "Bottom text", textNotifier: bottomText),
        ),
      ],
    );
  }
}

class _MemeInputText extends StatelessWidget {
  final String labelText;
  final ValueNotifier<String> textNotifier;

  const _MemeInputText({
    Key? key,
    required this.labelText,
    required this.textNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        initialValue: textNotifier.value,
        onChanged: (text) => textNotifier.value = text,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.all(16.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.white10),
          ),
        ),
        cursorColor: AppColors.blue,
        scrollPadding: EdgeInsets.all(80) + EdgeInsets.only(bottom: PrimaryButton.height),
      ),
    );
  }
}
