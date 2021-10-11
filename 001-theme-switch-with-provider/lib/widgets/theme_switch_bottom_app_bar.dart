import 'package:flutter/material.dart';
import 'package:theme_switch_with_provider/resources/icon/company_icons.dart';

class ThemeSwitchBottomAppBar extends StatelessWidget {
  final CompanyIcons icons;
  final Color onPrimaryColor;

  const ThemeSwitchBottomAppBar({
    Key? key,
    required this.icons,
    required this.onPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(icons.menu),
            color: onPrimaryColor,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(icons.search),
            color: onPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
