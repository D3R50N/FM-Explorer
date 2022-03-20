// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/pages/category_page.dart';
import 'package:flutter/material.dart';

class AllFiles extends StatefulWidget {
  const AllFiles(this.title, {Key? key}) : super(key: key);

  final String title;
  @override
  State<AllFiles> createState() => _AllFilesState();
}

class _AllFilesState extends State<AllFiles> {
  @override
  Widget build(BuildContext context) {
    return CategoryPage(widget.title);
  }
}
