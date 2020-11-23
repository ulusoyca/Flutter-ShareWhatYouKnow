import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ulusoyapps_flutter/extensions/color_extensions.dart';

class AppBarBackButton extends StatelessWidget {

  final Color color;

  const AppBarBackButton({Key key, @required this.color}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return kIsWeb ? SizedBox.shrink() : BackButton(color: color.onTextColor());
  }
}