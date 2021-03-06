import 'package:equatable/equatable.dart';

class ColorCode extends Equatable {
  final String hexColorCode;
  final ColorCodeSelectionSource source;

  ColorCode({this.hexColorCode, this.source});

  @override
  List<Object> get props => [hexColorCode, source];
}

enum ColorCodeSelectionSource { fromScroll, fromButtonClick, fromBrowserAddressBar }
