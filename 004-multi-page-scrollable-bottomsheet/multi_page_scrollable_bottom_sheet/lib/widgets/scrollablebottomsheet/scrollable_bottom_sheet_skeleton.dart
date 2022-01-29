import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/back_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/buttons/close_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/current/current_action_button_animated_builder.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/current/current_main_content_animated_builder.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/current/current_top_bar_widgets_animated_builder.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/outgoing/outgoing_action_button_animated_builder.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/outgoing/outgoing_main_content_animated_builder.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/outgoing/outgoing_top_bar_widgets_animated_builder.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_action_button.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_handler.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_page.dart';
import 'package:multi_page_scrollable_bottom_sheet/widgets/scrollablebottomsheet/scrollable_bottom_sheet_top_bar.dart';

import 'scrollable_bottom_sheet_main_content.dart';

class CurrentPageWidgets {
  final CurrentMainContentAnimatedBuilder mainContentAnimatedBuilder;
  final CurrentTopBarWidgetsAnimatedBuilder topBarAnimatedBuilder;
  final CurrentTopBarWidgetsAnimatedBuilder closeButtonAnimatedBuilder;
  final CurrentTopBarWidgetsAnimatedBuilder backButtonButtonAnimatedBuilder;
  final CurrentActionButtonAnimatedBuilder actionButtonAnimatedBuilder;
  final ScrollableBottomSheetMainContent offstagedMainContent;

  CurrentPageWidgets({
    required this.mainContentAnimatedBuilder,
    required this.topBarAnimatedBuilder,
    required this.closeButtonAnimatedBuilder,
    required this.backButtonButtonAnimatedBuilder,
    required this.actionButtonAnimatedBuilder,
    required this.offstagedMainContent,
  });
}

class OutgoingPageWidgets {
  final OutgoingMainContentAnimatedBuilder mainContentAnimatedBuilder;
  final OutgoingTopBarWidgetsAnimatedBuilder topBarAnimatedBuilder;
  final OutgoingTopBarWidgetsAnimatedBuilder closeButtonAnimatedBuilder;
  final OutgoingTopBarWidgetsAnimatedBuilder backButtonButtonAnimatedBuilder;
  final OutgoingActionButtonAnimatedBuilder actionButtonAnimatedBuilder;
  final ScrollableBottomSheetMainContent offstagedMainContent;

  OutgoingPageWidgets({
    required this.mainContentAnimatedBuilder,
    required this.topBarAnimatedBuilder,
    required this.closeButtonAnimatedBuilder,
    required this.backButtonButtonAnimatedBuilder,
    required this.actionButtonAnimatedBuilder,
    required this.offstagedMainContent,
  });
}

class ScrollableBottomSheetSkeleton extends StatefulWidget {
  final ValueNotifier<int> pageIndexListenable;
  final List<ScrollableBottomSheetPage> pages;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final int index;

  const ScrollableBottomSheetSkeleton({
    Key? key,
    required this.pageIndexListenable,
    required this.pages,
    required this.edgeInsetsDirectional,
    required this.index,
  }) : super(key: key);

  @override
  State<ScrollableBottomSheetSkeleton> createState() => _ScrollableBottomSheetSkeletonState();
}

class _ScrollableBottomSheetSkeletonState extends State<ScrollableBottomSheetSkeleton>
    with TickerProviderStateMixin {
  CurrentPageWidgets? _currentPageWidgets;
  OutgoingPageWidgets? _outgoingPageWidgets;

  int get pagesLength => widget.pages.length;

  int get _index => widget.index;

  final double _topBarHeight = 72;
  final double _pageTitleTopPadding = 12;
  final double _topBarTranslationYAmountInPx = 4;

  ScrollableBottomSheetPage get _page => widget.pages[_index];

  late List<GlobalKey> _titleKeys;
  late List<GlobalKey> _offstagedTitleKeys;
  late List<GlobalKey> _currentOffstagedMainContentKeys;
  late List<GlobalKey> _outgoingOffstagedMainContentKeys;

  AnimationController? _animationController;

  late List<ValueNotifier<double>> _scrollPositions;

  ValueNotifier<double> get _currentScrollPosition => _scrollPositions[_index];

  bool forwardMove = true;

  @override
  void initState() {
    super.initState();
    _offstagedTitleKeys = _createGlobalKeys();
    _titleKeys = _createGlobalKeys();
    _currentOffstagedMainContentKeys = _createGlobalKeys();
    _outgoingOffstagedMainContentKeys = _createGlobalKeys();
    _scrollPositions = [for (int i = 0; i < widget.pages.length; i++) ValueNotifier(0.0)];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_currentPageWidgets == null) {
      _addPage(animate: false);
    }
  }

  @override
  void didUpdateWidget(covariant ScrollableBottomSheetSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    forwardMove = oldWidget.index < widget.index;
    if (oldWidget.index != widget.index) {
      _addPage(animate: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidgets = _currentPageWidgets;
    final outgoingWidgets = _outgoingPageWidgets;
    return Stack(
      children: [
        _Skeleton(
          key: ValueKey("_Skeleton$_index"),
          mainContent: _SwitcherLayout(
            currentPageWidgets: currentWidgets?.mainContentAnimatedBuilder,
            outgoingChild: outgoingWidgets?.mainContentAnimatedBuilder,
          ),
          topBar: _SwitcherLayout(
            currentPageWidgets: currentWidgets?.topBarAnimatedBuilder,
            outgoingChild: outgoingWidgets?.topBarAnimatedBuilder,
          ),
          handler: const ScrollableBottomSheetHandler(),
          closeButtton: _SwitcherLayout(
            currentPageWidgets: currentWidgets?.closeButtonAnimatedBuilder,
            outgoingChild: outgoingWidgets?.closeButtonAnimatedBuilder,
          ),
          backButton: _SwitcherLayout(
            currentPageWidgets: currentWidgets?.backButtonButtonAnimatedBuilder,
            outgoingChild: outgoingWidgets?.backButtonButtonAnimatedBuilder,
          ),
          actionButton: _SwitcherLayout(
            currentPageWidgets: currentWidgets?.actionButtonAnimatedBuilder,
            outgoingChild: outgoingWidgets?.actionButtonAnimatedBuilder,
          ),
          edgeInsetsDirectional: widget.edgeInsetsDirectional,
          topBarHeight: _topBarHeight,
          topBarTranslationYAmountInPx: _topBarTranslationYAmountInPx,
        ),
        if (currentWidgets != null)
          Offstage(
            key: ValueKey("CurrentOffstage$_index"),
            offstage: true,
            child: _Skeleton(
              mainContent: KeyedSubtree(
                key: _currentOffstagedMainContentKeys[_index],
                child: currentWidgets.offstagedMainContent,
              ),
              topBar: currentWidgets.topBarAnimatedBuilder.child,
              handler: ScrollableBottomSheetHandler(),
              closeButtton: currentWidgets.closeButtonAnimatedBuilder.child,
              backButton: currentWidgets.backButtonButtonAnimatedBuilder.child,
              actionButton: currentWidgets.actionButtonAnimatedBuilder.actionButton,
              edgeInsetsDirectional: widget.edgeInsetsDirectional,
              topBarHeight: _topBarHeight,
              topBarTranslationYAmountInPx: _topBarTranslationYAmountInPx,
            ),
          ),
        if (outgoingWidgets != null)
          Offstage(
            key: ValueKey("_OutgoingOffstage$_index"),
            offstage: true,
            child: _Skeleton(
              mainContent: KeyedSubtree(
                key: _outgoingOffstagedMainContentKeys[_index],
                child: outgoingWidgets.offstagedMainContent,
              ),
              topBar: outgoingWidgets.topBarAnimatedBuilder.child,
              handler: const ScrollableBottomSheetHandler(),
              closeButtton: outgoingWidgets.closeButtonAnimatedBuilder.child,
              backButton: outgoingWidgets.backButtonButtonAnimatedBuilder.child,
              actionButton: outgoingWidgets.actionButtonAnimatedBuilder.actionButton,
              edgeInsetsDirectional: widget.edgeInsetsDirectional,
              topBarHeight: _topBarHeight,
              topBarTranslationYAmountInPx: _topBarTranslationYAmountInPx,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  List<GlobalKey<State<StatefulWidget>>> _createGlobalKeys() =>
      [for (int i = 0; i < widget.pages.length; i++) GlobalKey()];

  void _addPage({required bool animate}) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _outgoingPageWidgets = null);
          _animationController!.value = _animationController!.upperBound;
          _animationController?.dispose();
          _animationController = null;
        }
      });
    final currentWidgetsToBeOutgoing = _currentPageWidgets;
    if (currentWidgetsToBeOutgoing != null) {
      _outgoingPageWidgets = _createOutgoingWidgets(
        _animationController!,
        currentWidgetsToBeOutgoing,
      );
    }
    _currentPageWidgets = _createCurrentWidgets(_animationController!);
    if (animate) {
      _animationController?.forward();
    } else {
      _animationController?.value = 1.0;
    }
  }

  CurrentPageWidgets _createCurrentWidgets(AnimationController animationController) {
    return CurrentPageWidgets(
        mainContentAnimatedBuilder: CurrentMainContentAnimatedBuilder(
          mainContent: _createMainContent(_titleKeys[_index]),
          controller: animationController,
          currentOffstagedMainContentKey: _currentOffstagedMainContentKeys[_index],
          outgoingOffstagedMainContentKey: _outgoingOffstagedMainContentKeys[_index],
          forwardMove: forwardMove,
        ),
        offstagedMainContent: _createMainContent(_offstagedTitleKeys[_index]),
        topBarAnimatedBuilder: CurrentTopBarWidgetsAnimatedBuilder(
          child: _createTopBar(),
          controller: animationController,
        ),
        closeButtonAnimatedBuilder: CurrentTopBarWidgetsAnimatedBuilder(
          child: _createCloseButton(),
          controller: animationController,
        ),
        backButtonButtonAnimatedBuilder: CurrentTopBarWidgetsAnimatedBuilder(
          child: _createBackButton(),
          controller: animationController,
        ),
        actionButtonAnimatedBuilder: CurrentActionButtonAnimatedBuilder(
          actionButton: _createActionButton(),
          controller: animationController,
        ));
  }

  OutgoingPageWidgets _createOutgoingWidgets(
    AnimationController animationController,
    CurrentPageWidgets currentWidgetsToBeOutgoing,
  ) {
    return OutgoingPageWidgets(
        mainContentAnimatedBuilder: OutgoingMainContentAnimatedBuilder(
          controller: animationController,
          mainContent: currentWidgetsToBeOutgoing.mainContentAnimatedBuilder.mainContent,
          currentOffstagedMainContentKey: _currentOffstagedMainContentKeys[_index],
          outgoingOffstagedMainContentKey: _outgoingOffstagedMainContentKeys[_index],
          forwardMove: forwardMove,
        ),
        offstagedMainContent: currentWidgetsToBeOutgoing.offstagedMainContent,
        topBarAnimatedBuilder: OutgoingTopBarWidgetsAnimatedBuilder(
          controller: animationController,
          child: currentWidgetsToBeOutgoing.topBarAnimatedBuilder.child,
        ),
        closeButtonAnimatedBuilder: OutgoingTopBarWidgetsAnimatedBuilder(
          controller: animationController,
          child: currentWidgetsToBeOutgoing.closeButtonAnimatedBuilder.child,
        ),
        backButtonButtonAnimatedBuilder: OutgoingTopBarWidgetsAnimatedBuilder(
          controller: animationController,
          child: currentWidgetsToBeOutgoing.backButtonButtonAnimatedBuilder.child,
        ),
        actionButtonAnimatedBuilder: OutgoingActionButtonAnimatedBuilder(
          controller: animationController,
          actionButton: currentWidgetsToBeOutgoing.actionButtonAnimatedBuilder.actionButton,
        ));
  }

  ScrollableBottomSheetMainContent _createMainContent(GlobalKey titleKey) =>
      ScrollableBottomSheetMainContent(
        titleKey: titleKey,
        topBarHeight: _topBarHeight,
        edgeInsetsDirectional: widget.edgeInsetsDirectional,
        currentScrollPosition: _currentScrollPosition,
        hasActionButton: _page.actionListenable != null,
        heroImage: _page.heroImage,
        heroImageHeight: _page.heroImageHeight,
        content: _page.content,
        title: _page.title,
        titleTopPadding: _pageTitleTopPadding,
      );

  ScrollableBottomSheetTopBar _createTopBar() => ScrollableBottomSheetTopBar(
        topBarHeight: _topBarHeight,
        backgroundColor: _page.backgroundColor,
        currentScrollPositionListenable: _currentScrollPosition,
        topBarTitle: _page.appbarTitle,
        titleKey: _titleKeys[_index],
        heroImageHeight: _page.heroImageHeight,
        pageTitleTopPadding: _pageTitleTopPadding,
        topBarTranslationYAmountInPx: _topBarTranslationYAmountInPx,
      );

  BottomSheetCloseButton _createCloseButton() => BottomSheetCloseButton(
        onPressed: _page.onClosePressed,
      );

  Widget _createBackButton() => _index == 0
      ? const SizedBox.shrink()
      : BottomSheetBackButton(
          onPressed: _page.onBackPressed ??
              () => widget.pageIndexListenable.value = widget.pageIndexListenable.value - 1,
        );

  Widget _createActionButton() => _page.actionTextListenable == null
      ? const SizedBox.shrink()
      : ScrollableBottomSheetActionButton(
          edgeInsetsDirectional: widget.edgeInsetsDirectional,
          actionButtonColor: _page.actionButtonColor,
          actionTextListenable: _page.actionTextListenable,
          actionListenable: _page.actionListenable,
          actionButtonStateListenable: _page.actionButtonStateListenable,
          actionEnabledListenable: _page.actionEnabledListenable,
        );
}

class _SwitcherLayout extends StatelessWidget {
  final Widget? currentPageWidgets;
  final Widget? outgoingChild;

  const _SwitcherLayout({
    Key? key,
    required this.currentPageWidgets,
    required this.outgoingChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChild = this.currentPageWidgets;
    final outgoingChild = this.outgoingChild;
    return Stack(
      children: [
        if (outgoingChild != null) outgoingChild,
        if (currentChild != null) currentChild,
      ],
    );
  }
}

class _Skeleton extends StatelessWidget {
  final Widget mainContent;
  final Widget topBar;
  final Widget handler;
  final Widget closeButtton;
  final Widget backButton;
  final Widget actionButton;
  final EdgeInsetsDirectional edgeInsetsDirectional;
  final double topBarHeight;

  const _Skeleton({
    Key? key,
    required this.mainContent,
    required this.topBar,
    required this.handler,
    required this.closeButtton,
    required this.backButton,
    required this.actionButton,
    required this.edgeInsetsDirectional,
    required this.topBarHeight,
    required this.topBarTranslationYAmountInPx,
  }) : super(key: key);

  final handlerHeight = 12.0;
  final double topBarTranslationYAmountInPx;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mainContent,
        Positioned(
          left: 0,
          right: 0,
          top: -1 * topBarTranslationYAmountInPx,
          height: topBarHeight + topBarTranslationYAmountInPx,
          child: topBar,
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: ScrollableBottomSheetHandler(),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: Padding(
            padding: EdgeInsets.only(
                top: edgeInsetsDirectional.top - ScrollableBottomSheetHandler.topMargin),
            child: closeButtton,
          ),
        ),
        PositionedDirectional(
          top: 0,
          start: 0,
          child: Padding(
            padding: EdgeInsets.only(
                top: edgeInsetsDirectional.top - ScrollableBottomSheetHandler.topMargin),
            child: backButton,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: actionButton,
        ),
      ],
    );
  }
}
