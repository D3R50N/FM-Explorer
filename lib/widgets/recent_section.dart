import 'package:file_manager_app/contants.dart';
import 'package:file_manager_app/future_func.dart';
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
                    syncAllPath().then((value) {
                      GetStorageItems.init();
                    });
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
              child: Column(
                children: [
                  recentFile(
                    icondata: Icons.photo_library,
                    color: col_pht,
                    name: "andy.jpg",
                    size: 0.5,
                    date: "13 Nov. 2022",
                  ),
                  recentFile(
                    icondata: Icons.video_library,
                    color: col_vid,
                    name: "SNK S4E04.mp4",
                    size: 325,
                    date: "13 Nov. 2022",
                  ),
                  recentFile(
                    icondata: Icons.library_books,
                    color: col_doc,
                    name: "text.docx",
                    size: 12.17,
                    date: "13 Nov. 2022",
                  ),
                  recentFile(
                    icondata: Icons.library_music,
                    color: col_aud,
                    name: "igp5.mp3",
                    size: 2.3,
                    date: "13 Nov. 2022",
                  ),
                  recentFile(
                    icondata: Icons.archive,
                    color: col_rch,
                    name: "virus",
                    size: 1,
                    date: "13 Nov. 2022",
                  ),
                  recentFile(
                    icondata: Icons.upload_file_rounded,
                    color: col_zip,
                    name: "game.zip",
                    size: 10,
                    date: "13 Nov. 2022",
                  ),
                ],
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
