// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:io';

import 'package:file_manager_app/future_func.dart';
import 'package:file_manager_app/pages/internal_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_manager_app/contants.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(this.title, {Key? key}) : super(key: key);
  final String title;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isFound = false;
  List<String> type = [];
  List<String> result_files = [];

  @override
  void initState() {
    super.initState();
    type = textAndType[widget.title.toLowerCase()] ?? [];
    search();
  }

  void search() {
    result_files.clear();
    for (var elementPath in GetStorageItems.getAllFiles) {
      String element = elementPath.split(Platform.pathSeparator).last;
      if (type.contains(fileExt(element))) {
        result_files.add(elementPath);
      }
    }
    if (result_files.isNotEmpty) {
      setState(() {
        isFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   GetStorageItems.init();
    // });

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Liste des " +
              widget.title.toLowerCase() +
              " (" +
              result_files.length.toString() +
              ")",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: isFound
          ? ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: result_files.length,
              itemBuilder: (context, index) {
                List<String> sep =
                    result_files[index].split(Platform.pathSeparator);
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
            )
          : oups(),
    );
  }
}
