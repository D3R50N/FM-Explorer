// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.isSelected,
    required this.nbItems,
    required this.nbSelected,
    required this.selectAll,
    required this.createFile,
    required this.createFolder,
  }) : super(key: key);

  final bool isSelected;
  final int nbItems;
  final int nbSelected;
  final Function() selectAll;
  final Function(String name) createFile;
  final Function(String name) createFolder;
  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  String filename = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              "Tous les fichiers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          widget.isSelected
              ? widget.nbSelected < widget.nbItems
                  ? Flexible(
                      child: TextButton(
                        onPressed: () => {widget.selectAll()},
                        child: Text(
                          "Tout sélectionner(" +
                              widget.nbItems.toString() +
                              ")",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  : Flexible(
                      child: TextButton(
                        onPressed: () => {widget.selectAll()},
                        child: Text(
                          "Tout désélectionner(" +
                              widget.nbItems.toString() +
                              ")",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: "search_bar",
                      child: SizedBox(
                        width: 30,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return SearchPage();
                              },
                            ));
                          },
                          icon: Icon(Icons.search),
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black.withOpacity(.7),
                        ),
                        itemBuilder: (BuildContext context) {
                          return {
                            'Nouveau fichier',
                            'Nouveau dossier',
                            'Trier',
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        onSelected: (s) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: s == "Nouveau fichier"
                                      ? Text('Nom ou chemin du fichier')
                                      : Text('Nom ou chemin du dossier'),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        s == "Nouveau fichier"
                                            ? widget.createFile(filename)
                                            : widget.createFolder(filename);
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ],
                                  content: TextField(
                                    onChanged: (value) {
                                      filename = value;
                                    },
                                    decoration: InputDecoration(hintText: ""),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
