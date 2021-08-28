import 'package:equatable/equatable.dart';

class ColorCode extends Equatable {
  final String hexColorCode;
  final ColorCodeSelectionSource source;

  ColorCode({required this.hexColorCode, required this.source});

  @override
  List<Object?> get props => [hexColorCode, source];
}

enum ColorCodeSelectionSource { fromScroll, fromButtonClick, fromBrowserAddressBar }
