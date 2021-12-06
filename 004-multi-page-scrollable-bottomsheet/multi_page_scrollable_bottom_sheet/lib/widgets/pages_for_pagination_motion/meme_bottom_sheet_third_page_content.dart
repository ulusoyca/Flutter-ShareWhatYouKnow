import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/circular_button.dart';

class MemeBottomSheetThirdPageContent extends StatelessWidget {
  final ValueNotifier<int> selectedImageIndex;
  final ValueNotifier<int> pageIndexNotifier;
  final ValueNotifier<String> topText;
  final ValueNotifier<String> bottomText;

  const MemeBottomSheetThirdPageContent(
      {Key? key,
      required this.selectedImageIndex,
      required this.pageIndexNotifier,
      required this.topText,
      required this.bottomText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: _MemeWithText(
            bottomText: bottomText,
            topText: topText,
            selectedImageIndex: selectedImageIndex,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: _SharingOptions(),
        ),
      ],
    );
  }
}

class _SharingOptions extends StatelessWidget {
  const _SharingOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 40,
        spacing: 40,
        children: [
          _SharingOption(label: "Copy link", icon: MdiIcons.linkVariant),
          _SharingOption(label: "Facebook", icon: MdiIcons.facebook),
          _SharingOption(label: "Twitter", icon: MdiIcons.twitter),
        ]);
  }
}

class _SharingOption extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SharingOption({Key? key, required this.label, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircularButton(iconData: icon, colorName: AppColorNames.blue),
      SizedBox(height: 4),
      Text(
        label,
        style: Theme.of(context).textTheme.caption!.copyWith(color: AppColors.blue),
      )
    ]);
  }
}

class _MemeWithText extends StatelessWidget {
  final ValueNotifier<int> selectedImageIndex;
  final ValueNotifier<String> topText;
  final ValueNotifier<String> bottomText;

  const _MemeWithText({
    Key? key,
    required this.selectedImageIndex,
    required this.topText,
    required this.bottomText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Image(
              image: AssetImage('assets/cats_meme_${selectedImageIndex.value}.png'),
              width: constraints.maxWidth,
              fit: BoxFit.fitWidth,
            ),
            Positioned(right: 24, left: 24, top: 16, child: _MemeText(text: topText.value)),
            Positioned(right: 24, left: 24, bottom: 16, child: _MemeText(text: bottomText.value)),
          ],
        );
      },
    );
  }
}

class _MemeText extends StatelessWidget {
  final String text;

  const _MemeText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = AppColors.black,
              ),
        ),
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3!.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
