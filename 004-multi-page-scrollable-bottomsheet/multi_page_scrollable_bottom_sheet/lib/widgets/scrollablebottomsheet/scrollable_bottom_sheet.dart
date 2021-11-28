import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_container.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_page.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_skeleton.dart';

const _emptyContainerLayoutId = 'empty_container';
const _bottomSheetLayoutId = 'bottomSheet';

/// maxHeightFactor
Future<T?> showScrollableWoltBottomSheet<T>(
    {required BuildContext context,
    required List<ScrollableWoltBottomSheetPage> Function(BuildContext) pages,
    ValueNotifier<int>? pageIndexListenable,
    EdgeInsetsDirectional? edgeInsetsDirectional,
    ScrollController? scrollController,
    Widget Function(Widget)? decorator,
    RouteSettings? routeSettings}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
      final bottomSheet = WoltScrollableBottomSheet(
        bottomSheetPageBuilders: pages,
        pageIndexListenable: pageIndexListenable ?? ValueNotifier(0),
        scrollController: scrollController,
        edgeInsetsDirectional: edgeInsetsDirectional,
      );
      return decorator == null ? bottomSheet : decorator(bottomSheet);
    },
    routeSettings: routeSettings,
  );
}

class WoltScrollableBottomSheet extends StatefulWidget {
  const WoltScrollableBottomSheet({
    required this.bottomSheetPageBuilders,
    required this.pageIndexListenable,
    this.scrollController,
    this.edgeInsetsDirectional,
    Key? key,
  }) : super(key: key);

  final List<ScrollableWoltBottomSheetPage> Function(BuildContext) bottomSheetPageBuilders;
  final ValueNotifier<int> pageIndexListenable;
  final EdgeInsetsDirectional? edgeInsetsDirectional;
  final ScrollController? scrollController;

  @override
  _WoltScrollableBottomSheetState createState() => _WoltScrollableBottomSheetState();
}

class _WoltScrollableBottomSheetState extends State<WoltScrollableBottomSheet>
    with TickerProviderStateMixin {
  int get _index => widget.pageIndexListenable.value;

  ScrollableWoltBottomSheetPage get _page => _pages![_index];

  List<ScrollableWoltBottomSheetPage>? _pages;

  EdgeInsetsDirectional get _edgeInsetsDirectional =>
      widget.edgeInsetsDirectional ?? EdgeInsetsDirectional.all(16);

  @override
  void didChangeDependencies() {
    _pages ??= widget.bottomSheetPageBuilders(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.pageIndexListenable,
      builder: (BuildContext context, int value, Widget? child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomMultiChildLayout(
                  delegate: _BottomSheetContainerLayoutDelegate(),
                  children: [
                    LayoutId(
                      id: _emptyContainerLayoutId,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.maybePop(context);
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                    LayoutId(
                      id: _bottomSheetLayoutId,
                      child: ScrollableBottomSheetContainer(
                        backgroundColor: _page.backgroundColor,
                        child: Container(
                          color: _page.backgroundColor,
                          child: ScrollableBottomSheetSkeleton(
                            edgeInsetsDirectional: _edgeInsetsDirectional,
                            pageIndexListenable: widget.pageIndexListenable,
                            index: value,
                            pages: _pages!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).padding.bottom,
              color: _page.backgroundColor,
            ),
          ],
        );
      },
    );
  }
}

class _BottomSheetContainerLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size bottomSheetContainerSize = Size.zero;
    bottomSheetContainerSize = layoutChild(
      _bottomSheetLayoutId,
      BoxConstraints(
        maxHeight: size.height * 0.9,
        minHeight: size.height * 0.4,
        maxWidth: size.width,
        minWidth: size.width,
      ),
    );
    positionChild(_bottomSheetLayoutId, Offset(0, size.height - bottomSheetContainerSize.height));

    layoutChild(
      _emptyContainerLayoutId,
      BoxConstraints(
          maxWidth: size.width, maxHeight: size.height - bottomSheetContainerSize.height),
    );
    positionChild(_emptyContainerLayoutId, const Offset(0, 0));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}