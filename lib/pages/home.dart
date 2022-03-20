// ignore_for_file: prefer_const_constructors

import 'package:file_manager_app/contants.dart';
import 'package:file_manager_app/future_func.dart';
import 'package:file_manager_app/pages/search_page.dart';
import 'package:file_manager_app/widgets/recent_section.dart';
import 'package:file_manager_app/widgets/storage_section.dart';
import 'package:file_manager_app/widgets/home_app_bar.dart';
import 'package:file_manager_app/widgets/categories_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> reqPerm() async {
  await Permission.storage.request();
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState();
  bool allPathLoaded = false;

  @override
  void initState() {
    super.initState();
    reqPerm().then((value) {
      syncAllPath().then((value) {
        setState(() {
          allPathLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: HomeAppBar(),
      body: !allPathLoaded
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Gap(10),
                Text(
                  "Chargement des données",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00C4FE),
                  ),
                )
              ],
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Row(
                    children: [
                      Gap(20),
                      Expanded(
                        child: Hero(
                          tag: "search_bar",
                          child: InkWell(
                            child: SearchBar(false, (String t) {}),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SearchPage();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(20),
                    ],
                  ),
                  const StorageSection(),
                  CategoriesSection(),
                  const RecentSection(),
                  Gap(20),
                ],
              ),
            ),
    );
  }
}
