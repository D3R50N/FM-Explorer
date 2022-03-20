import 'package:animations/animations.dart';
import 'package:file_manager_app/contants.dart';
import 'package:file_manager_app/pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import './storage_card.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
            "Categories",
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Row(
          children: [
            Gap(10),
            Expanded(
              child: Card(
                elevation: 0,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: GridView.count(
                  crossAxisSpacing: 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  padding: const EdgeInsets.all(10),
                  childAspectRatio: (MediaQuery.of(context).size.width * 2) /
                      (MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          24),
                  children: [
                    category(
                      icondata: Icons.photo_library,
                      color: crgb(255, 148, 75),
                      title: "Images",
                      context: context,
                    ),
                    category(
                      icondata: Icons.video_library,
                      color: crgb(255, 70, 90),
                      title: "Vidéos",
                      context: context,
                    ),
                    category(
                      icondata: Icons.library_books,
                      color: crgb(27, 139, 248),
                      title: "Documents",
                      context: context,
                    ),
                    category(
                      icondata: Icons.library_music,
                      color: crgb(0, 218, 153),
                      title: "Audios",
                      context: context,
                    ),
                    category(
                      icondata: Icons.archive,
                      color: crgb(179, 89, 247),
                      title: "Archive",
                      context: context,
                    ),
                    category(
                      icondata: Icons.upload_file_rounded,
                      color: crgb(0, 195, 254),
                      title: "Zip",
                      context: context,
                    ),
                    category(
                      icondata: Icons.download_done_outlined,
                      color: crgb(242, 82, 229),
                      title: "Téléchargements",
                      context: context,
                    ),
                    category(
                      icondata: Icons.grid_view_rounded,
                      color: crgb(190, 190, 190),
                      title: "Autres",
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
            Gap(10),
          ],
        ),
      ],
    );
  }
}

Widget category(
    {required IconData icondata,
    required String title,
    required BuildContext context,
    Color color = const Color.fromRGBO(0, 192, 250, 1)}) {
  return OpenContainer(
    closedBuilder: (context, action) {
      return Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: crgb(253, 250, 249),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icondata,
                color: color,
              ),
            ),
            Flexible(
              child: Text(
                title,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    },
    openBuilder: (context, action) {
      return CategoryPage(title);
    },
    transitionDuration: Duration(milliseconds: 300),
    closedElevation: 0,
  );
}
