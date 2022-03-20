// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:file_manager_app/contants.dart';
import 'package:file_manager_app/future_func.dart';
import 'package:file_manager_app/pages/all_files_page.dart';
import 'package:file_manager_app/pages/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import './storage_card.dart';

class RecentSection extends StatelessWidget {
  const RecentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fichiers Récents",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AllFiles("fichiers");
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Voir Tout",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Gap(10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<String> sep = GetStorageItems.getAllFiles[index]
                      .split(Platform.pathSeparator);
                  String name = sep.last;
                  String path = sep
                          .sublist(0, sep.length - 1)
                          .join(Platform.pathSeparator) +
                      Platform.pathSeparator;
                  File f = File(path + name);
                  return FileCard(
                    icondata:
                        extAndIcon[fileExt(name)] ?? Icons.file_copy_rounded,
                    parentPath: path,
                    size: perfectSize(f.lengthSync()),
                    lastDate: f.lastAccessedSync().toString().split(" ").first,
                    color: extAndCol[fileExt(name)] ?? crgb(100, 100, 100),
                    name: name,
                    selectItem: (String s) {},
                    onGoBack: (dynamic v) {},
                    deselectItem: (String s) {},
                    oneIsSelected: false,
                  );
                },
              ),
            ),
            Gap(10),
          ],
        ),
      ],
    );
  }
}

Widget recentFile(
    {required IconData icondata,
    required String name,
    required double size,
    required String date,
    Color color = const Color.fromRGBO(0, 192, 250, 1)}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    color: Colors.transparent,
    height: 100,
    child: Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          onPressed: () => {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: crgb(253, 250, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icondata,
                    color: color,
                  ),
                ),
                Gap(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Gap(8),
                    Flexible(
                      child: Text(
                        size.toString() + "MB • " + date,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
