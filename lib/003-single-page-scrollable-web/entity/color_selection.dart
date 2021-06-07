import 'package:equatable/equatable.dart';

class ColorCodeSelection extends Equatable {
  final String hexColorCode;
  final ColorCodeSelectionSource source;

  ColorCodeSelection({this.hexColorCode, this.source});

  @override
  List<Object> get props => [hexColorCode, source];
}

enum ColorCodeSelectionSource { fromScroll, fromButtonClick, fromBrowserAddressBar }
