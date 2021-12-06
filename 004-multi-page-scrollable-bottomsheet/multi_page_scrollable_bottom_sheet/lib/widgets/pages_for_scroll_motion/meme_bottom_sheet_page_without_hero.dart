import 'package:flutter/material.dart';

class MemeBottomSheetPageWithoutHero extends StatelessWidget {
  final ValueNotifier<int> selectedImageIndex;
  final ValueNotifier<int> pageIndexNotifier;

  const MemeBottomSheetPageWithoutHero({
    Key? key,
    required this.selectedImageIndex,
    required this.pageIndexNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Let’s start by selecting a base image for your custom meme. You’ll add text in the next step",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: _MemeListColumn(
                selectedImageIndex: selectedImageIndex,
                pageIndexNotifier: pageIndexNotifier,
                firstColumn: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: _MemeListColumn(
                selectedImageIndex: selectedImageIndex,
                pageIndexNotifier: pageIndexNotifier,
                firstColumn: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MemeListColumn extends StatelessWidget {
  final bool firstColumn;

  const _MemeListColumn({
    Key? key,
    required this.selectedImageIndex,
    required this.pageIndexNotifier,
    required this.firstColumn,
  }) : super(key: key);

  final ValueNotifier<int> selectedImageIndex;
  final ValueNotifier<int> pageIndexNotifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        final columnIndex = index + (firstColumn ? 0 : 6);
        return InkWell(
          child: Image.asset('assets/cats_meme_$columnIndex.png'),
          onTap: () {
            selectedImageIndex.value = columnIndex;
            pageIndexNotifier.value = 1;
          },
        );
      },
    );
  }
}
