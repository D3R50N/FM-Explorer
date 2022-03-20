// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/contants.dart';
import 'package:flutter/material.dart';

class InternalStorageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const InternalStorageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: componentColor,
      shadowColor: Colors.transparent,
    );
  }

  Size get preferredSize => AppBar().preferredSize;
}
