// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/pages/profile_page.dart';
import 'package:file_manager_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import '../future_func.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      title: Text(
        // "Tous mes Fichiers (" + GetStorageItems.length.toString() + ")",
        "FM Explorer",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black,
        ),
      ),
      actions: [
        Hero(
          tag: "profile_page",
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage();
                  },
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("images/img1.jpg"),
              radius: 15,
            ),
          ),
        ),
        Gap(20),
      ],
    );
  }

  Size get preferredSize => AppBar().preferredSize;
}
