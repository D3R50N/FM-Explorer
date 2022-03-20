import 'dart:io';

import 'package:disk_space/disk_space.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import './storage_card.dart';

Future<List<String>> get localPath async {
  var paths = await ExternalPath.getExternalStorageDirectories();
  // print(paths);
  return paths;
}

Future<List<double>> storageInfos(String path) async {
  List<double> l = [];
  var free = await DiskSpace.getFreeDiskSpaceForPath(path);
  var total = await DiskSpace.getTotalDiskSpace;

  l.add(free ?? 0);
  l.add(total ?? 0);
  return l;
}

class StorageSection extends StatefulWidget {
  const StorageSection({Key? key}) : super(key: key);

  @override
  State<StorageSection> createState() => _StorageSectionState();
}

class _StorageSectionState extends State<StorageSection> {
  String homePath = "";
  String sdPath = "";

  bool homeNotFound = false;
  bool sdNotFound = false;

  List<double> homeSpace = [0, 0];
  List<double> sdSpace = [0, 0];

  @override
  Widget build(BuildContext context) {
    if (homePath == "") {
      localPath.then((value) {
        setState(() {
          if (value.isNotEmpty) {
            homePath = value[0];
            storageInfos(homePath).then((listvalue) {
              setState(() {
                homeSpace = [
                  double.parse(listvalue[0].toStringAsFixed(2)),
                  double.parse(listvalue[1].toStringAsFixed(2)),
                ];
              });
            });
          } else {
            homeNotFound = true;
            sdNotFound = true;
          }
          if (value.length > 1) {
            sdPath = value[1];
            storageInfos(sdPath).then((listvalue) {
              print(listvalue);

              setState(() {
                sdSpace = [
                  double.parse(listvalue[0].toStringAsFixed(2)),
                  double.parse(listvalue[1].toStringAsFixed(2)),
                ];
              });
            });
          } else {
            sdNotFound = true;
          }
        });
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Text(
            "Stockages",
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                StorageCard(
                  icondata: Icons.phone_android,
                  title: "Stockage Interne",
                  freeSpace: homeSpace[0],
                  usedSpace: homeSpace[1] - homeSpace[0],
                  context: context,
                  path: homePath + Platform.pathSeparator,
                  isCharged: homePath != "",
                  notFound: homeNotFound,
                ),
                StorageCard(
                  icondata: Icons.sd_card,
                  title: "Stockage Externe",
                  freeSpace: sdSpace[0],
                  usedSpace: sdSpace[1] - sdSpace[0],
                  context: context,
                  path: sdPath + "/",
                  notFound: sdNotFound,
                  isCharged: sdPath != "",
                ),
                StorageCard(
                  icondata: Icons.cloud,
                  title: "Stockage Cloud",
                  freeSpace: 13.7,
                  usedSpace: 1.3,
                  context: context,
                  path: "/storage/emulated/0/",
                  notFound: false,
                  isCharged: homePath != "",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
