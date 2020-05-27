import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  CustomAppBar({Key key, this.customPreferredSize}) : super(key: key);

  final Size customPreferredSize;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: customPreferredSize,
      child: Container(),
    );
  }

  @override
  Size get preferredSize => customPreferredSize;
}
