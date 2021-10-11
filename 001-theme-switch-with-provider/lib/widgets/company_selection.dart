import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:theme_switch_with_provider/resources/strings/app_strings.dart';
import 'package:theme_switch_with_provider/resources/themes/company_name.dart';

class CompanySelection extends StatefulWidget {
  const CompanySelection({
    Key? key,
    required this.toggleButtonShapeBorder,
    required this.onCompanySelected,
  }) : super(key: key);

  final ShapeBorder toggleButtonShapeBorder;
  final Function(CompanyName) onCompanySelected;

  @override
  _CompanySelectionState createState() => _CompanySelectionState();
}

class _CompanySelectionState extends State<CompanySelection> {
  List<bool> _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: widget.toggleButtonShapeBorder,
      elevation: 2.0,
      type: MaterialType.canvas,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ToggleButtons(
        children: [
          _toggleButtonChild(AppStrings.COMPANY_ATA),
          _toggleButtonChild(AppStrings.COMPANY_BIOHACK),
          _toggleButtonChild(AppStrings.COMPANY_CODELAND),
        ],
        onPressed: (int index) {
          switch (index) {
            case 0:
              widget.onCompanySelected(CompanyName.ATA);
              break;
            case 1:
              widget.onCompanySelected(CompanyName.BIOHACK);
              break;
            case 2:
              widget.onCompanySelected(CompanyName.CODELAND);
              break;
          }
          setState(() {
            for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
              if (buttonIndex == index) {
                _isSelected[buttonIndex] = true;
              } else {
                _isSelected[buttonIndex] = false;
              }
            }
          });
        },
        isSelected: _isSelected,
      ),
    );
  }

  Widget _toggleButtonChild(String text) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.SIZE_SPACING_LARGE),
        child: Text(text),
      );
}
