// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InternalStorageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const InternalStorageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }

  Size get preferredSize => AppBar().preferredSize;
}
