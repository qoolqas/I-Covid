import 'package:flutter/material.dart';
import 'package:ico/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      actions: <Widget>[
        // Image.asset("assets/images/logo_small.png")
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(4.0);
}
