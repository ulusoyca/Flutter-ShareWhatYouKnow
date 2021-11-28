import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';

enum PrimaryButtonState { idle, loading }

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required this.text,
    required this.colorName,
    this.onPressed,
    this.disabled = false,
    this.buttonState,
    Key? key,
  }) : super(key: key);

  final bool disabled;
  final VoidCallback? onPressed;
  final String text;
  final ValueListenable<PrimaryButtonState>? buttonState;
  final AppColorNames colorName;

  @override
  State<StatefulWidget> createState() => _PrimaryButtonState();

  static final double height = 56;
}

class _PrimaryButtonState extends State<PrimaryButton> {
  late ValueListenable<PrimaryButtonState> _buttonState;

  Color get color100 => widget.colorName.color100;

  Color get color60 => widget.colorName.color60;

  Color get color38 => widget.colorName.color38;

  Color get color24 => widget.colorName.color24;

  Color get color10 => widget.colorName.color10;

  Color _onColor(bool disabled) => disabled ? color24 : Colors.white;

  Color _backgroundColor(disabled) => disabled ? color60 : color100;

  Color get _splashColor => Colors.white12;

  @override
  void initState() {
    super.initState();
    _buttonState = widget.buttonState ?? ValueNotifier(PrimaryButtonState.idle);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _buttonState,
      builder: (BuildContext context, PrimaryButtonState value, Widget? child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: AnimatedContainer(
            width: double.infinity,
            height: PrimaryButton.height,
            duration: const Duration(milliseconds: 150),
            child: ElevatedButton(
              style: _buttonStyle,
              // To disable, press action should be null
              onPressed: widget.disabled || _buttonState.value == PrimaryButtonState.loading
                  ? null
                  : widget.onPressed,
              child: _buttonState.value == PrimaryButtonState.loading
                  ? SizedBox.square(
                      dimension: PrimaryButton.height / 2,
                      child: CircularProgressIndicator(color: Colors.white))
                  : Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: _onColor(widget.disabled),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
            ),
          ),
        );
      },
    );
  }

  ButtonStyle get _buttonStyle => ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => _onColor(states.contains(MaterialState.disabled)),
        ),
        overlayColor: MaterialStateProperty.all<Color>(_splashColor),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => _backgroundColor(
            states.contains(MaterialState.disabled),
          ),
        ),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
}
