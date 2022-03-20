// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:file_manager_app/contants.dart';
import 'package:file_manager_app/pages/home.dart';
import 'package:file_manager_app/pages/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';

Widget StorageCard({
  required IconData icondata,
  required String title,
  required String path,
  required double usedSpace,
  required double freeSpace,
  required BuildContext context,
  required bool isCharged,
  required bool notFound,
}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.all(5),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      color: componentColor,
      shadowColor: Colors.grey.shade900,
      child: notFound
          ? card_text_button(
              icondata,
              title,
              usedSpace,
              freeSpace,
              context,
              isCharged,
              notFound,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: OpenContainer(
                closedColor: componentColor,
                closedElevation: 2,
                transitionDuration: Duration(milliseconds: 300),
                closedBuilder: (context, action) {
                  return card_text_button(
                    icondata,
                    title,
                    usedSpace,
                    freeSpace,
                    context,
                    isCharged,
                    notFound,
                  );
                },
                openBuilder: (context, action) {
                  return InternalStorage(
                    icondata,
                    title,
                    usedSpace.roundToDouble(),
                    freeSpace.roundToDouble(),
                    path,
                  );
                },
              ),
            ),
    ),
  );
}

class card_text_button extends StatelessWidget {
  IconData icondata;
  String title;
  double usedSpace;
  double freeSpace;
  BuildContext context;
  bool isCharged;
  bool isNotfound;

  card_text_button(this.icondata, this.title, this.usedSpace, this.freeSpace,
      this.context, this.isCharged, this.isNotfound,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 170,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.grey.shade900,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 250, 249, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icondata,
                  color: Color.fromRGBO(0, 192, 250, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              isNotfound
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 20, right: 20),
                      child: Center(
                        child: Text(
                          "stockage introuvable",
                          style: GoogleFonts.dmSans(
                            fontStyle: FontStyle.italic,
                            color: textColor,
                          ),
                        ),
                      ),
                    )
                  : isCharged
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ((usedSpace > 1000)
                                            ? (usedSpace / 1000)
                                                    .toStringAsFixed(2) +
                                                " GB"
                                            : usedSpace.toStringAsFixed(2) +
                                                " MB") +
                                        " utilisé",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  Text(
                                    (freeSpace > 1000)
                                        ? (freeSpace / 1000)
                                                .toStringAsFixed(2) +
                                            " libre"
                                        : freeSpace.toStringAsFixed(2) +
                                            " libre",
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                width: 210,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey.shade500,
                                    color: Color.fromRGBO(0, 195, 253, 1),
                                    value: (usedSpace != 0 && freeSpace != 0)
                                        ? usedSpace / (usedSpace + freeSpace)
                                        : 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
