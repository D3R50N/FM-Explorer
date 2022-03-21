// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/pages/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

import '../contants.dart';

class ItemsCard extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ItemsCard({
    Key? key,
    required this.icondata,
    required this.name,
    required this.isFolder,
    required this.activeSelectItem,
    required this.deactiveSelectItem,
    required this.onGoBack,
    required this.oneIsSelected,
    required this.parentPath,
    this.size = "0KB",
    this.date = "",
    this.itemsCount = 0,
    this.color = const Color.fromRGBO(0, 192, 250, 1),
    this.isCreatedWithSelect = true,
  });

  final IconData icondata;
  final bool isFolder;
  final String name;
  final String parentPath;
  final String size;
  final String date;
  final int itemsCount;
  final Color color;
  final bool isCreatedWithSelect;

  final Function(String itemName) activeSelectItem;
  final Function(dynamic value) onGoBack;
  final Function(String itemName) deactiveSelectItem;
  final bool oneIsSelected;
  // final Function() oneIsSelected;
  @override
  ItemsCardState createState() => ItemsCardState();
}

class ItemsCardState extends State<ItemsCard> {
  bool isSelected = false;

  void selectItem() {
    setState(() {
      isSelected = true;
      widget.activeSelectItem(widget.name);
    });
  }

  void deselectItem() {
    setState(() {
      isSelected = false;
      widget.deactiveSelectItem(widget.name);
    });
  }

  void openFolder(BuildContext context) {
    Navigator.of(context)
        .push(
          PageRouteBuilder(
            reverseTransitionDuration: Duration(milliseconds: 50),
            pageBuilder: (c, a1, a2) => InternalStorage(
                main_icondata,
                widget.name,
                main_usedSpace,
                main_freeSpace,
                widget.parentPath + widget.name + "/"),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 50),
          ),
        )
        .then(widget.onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    var col = crgb(0, 149, 233);

    return Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.transparent,
      height: 90,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? col : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Card(
          color: componentColor,
          margin: const EdgeInsets.all(0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: TextButton(
              onPressed: () {
                if (isSelected) {
                  deselectItem();
                } else if (widget.oneIsSelected) {
                  selectItem();
                } else {
                  if (widget.isFolder) {
                    openFolder(context);
                  } else {
                    //TODO Ouverture de fichier
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Ouverture de " + widget.name),
                    //   duration: Duration(milliseconds: 300),
                    // ));
                    OpenFile.open(widget.parentPath + widget.name);
                  }
                }
              },
              onLongPress: () => {
                if (!isSelected) selectItem(),
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.icondata,
                          color: widget.color,
                        ),
                      ),
                    ),
                    Gap(5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            widget.name.length > 20
                                ? widget.name.substring(0, 17) + ".."
                                : widget.name,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                        ),
                        Gap(8),
                        Flexible(
                          child: Text(
                            widget.isFolder
                                ? widget.itemsCount.toString() + " éléments"
                                : widget.size + " • " + widget.date,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    if (widget.isFolder && !isSelected && !widget.oneIsSelected)
                      (ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: TextButton(
                          onPressed: () => {
                            openFolder(context),
                          },
                          child: Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Colors.grey.shade500,
                            size: 30,
                          ),
                        ),
                      )),
                    if (widget.oneIsSelected && !isSelected)
                      (ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () => {
                              selectItem(),
                            },
                            child: Icon(
                              Icons.check_box_outline_blank_rounded,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                      )),
                    if (isSelected)
                      (ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () => {
                              deselectItem(),
                            },
                            child: Icon(
                              Icons.check_box_rounded,
                              color: col,
                              size: 30,
                            ),
                          ),
                        ),
                      )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
