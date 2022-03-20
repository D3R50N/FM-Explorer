// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:file_manager_app/contants.dart';
import 'package:file_manager_app/future_func.dart';
import 'package:file_manager_app/widgets/search_bar.dart';
import './internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  List<String> result_folders = [];
  List<String> result_files = [];
  void queryChanged(String newquery) {
    setState(() {
      query = newquery;
    });
    search();
  }

  void search() {
    result_folders.clear();
    result_files.clear();
    for (var elementPath in GetStorageItems.getAllFiles) {
      String element = elementPath.split(Platform.pathSeparator).last;
      if (element.toLowerCase().contains(query.toLowerCase())) {
        result_files.add(elementPath);
      }
    }
    for (var elementPath in GetStorageItems.getAllFolders) {
      String element = elementPath.split(Platform.pathSeparator).last;

      if (element.toLowerCase().contains(query.toLowerCase())) {
        result_folders.add(elementPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "search_bar",
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(244, 247, 250, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey.shade300,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              // Gap(20),
              Expanded(child: SearchBar(true, queryChanged)),
              // Gap(20),
            ],
          ),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: Row(
            //     children: [
            //       // Gap(20),
            //       Expanded(child: SearchBar(true, queryChanged)),
            //       // Gap(20),
            //     ],
            //   ),
            // ),
            if (query.isEmpty ||
                (result_files.isEmpty && result_folders.isEmpty))
              Expanded(
                child: Center(
                  child: oups(),
                ),
              ),
            if (query.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (result_folders.isNotEmpty) Gap(20),
                      if (result_folders.isNotEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Dossiers (" +
                                    result_folders.length.toString() +
                                    ")",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: result_folders.length,
                              itemBuilder: (context, index) {
                                List<String> sep = result_folders[index]
                                    .split(Platform.pathSeparator);
                                String name = sep.last;
                                String path = sep
                                        .sublist(0, sep.length - 1)
                                        .join(Platform.pathSeparator) +
                                    Platform.pathSeparator;
                                Directory d = Directory(path + name);
                                return FolderCard(
                                  parentPath: path,
                                  name: name,
                                  itemsCount: d.listSync().length,
                                  selectItem: (String s) {},
                                  onGoBack: (dynamic v) {},
                                  deselectItem: (String s) {},
                                  oneIsSelected: false,
                                );
                              },
                            ),
                          ],
                        ),
                      if (result_folders.isNotEmpty) Gap(50),
                      if (result_folders.isEmpty && result_files.isNotEmpty)
                        Gap(20),
                      if (result_files.isNotEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Fichiers (" +
                                    result_files.length.toString() +
                                    ")",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: result_files.length,
                              itemBuilder: (context, index) {
                                List<String> sep = result_files[index]
                                    .split(Platform.pathSeparator);
                                String name = sep.last;
                                String path = sep
                                        .sublist(0, sep.length - 1)
                                        .join(Platform.pathSeparator) +
                                    Platform.pathSeparator;
                                File f = File(path + name);
                                return FileCard(
                                  icondata: extAndIcon[fileExt(name)] ??
                                      Icons.file_copy_rounded,
                                  parentPath: path,
                                  size: perfectSize(f.lengthSync()),
                                  lastDate: f
                                      .lastAccessedSync()
                                      .toString()
                                      .split(" ")
                                      .first,
                                  color: extAndCol[fileExt(name)] ??
                                      crgb(100, 100, 100),
                                  name: name,
                                  selectItem: (String s) {},
                                  onGoBack: (dynamic v) {},
                                  deselectItem: (String s) {},
                                  oneIsSelected: false,
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
