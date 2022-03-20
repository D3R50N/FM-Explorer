// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:file_manager_app/future_func.dart';
import 'package:file_manager_app/helpers/items_cache.dart';
import 'package:file_manager_app/pages/home.dart';
import 'package:file_manager_app/widgets/header.dart';
import 'package:file_manager_app/widgets/id_card_storage.dart';
import 'package:file_manager_app/widgets/items_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../contants.dart';
import '../widgets/internal_storage_app_bar.dart';

String perfectSize(int sizeInBytes) {
  String res = "";
  double size = sizeInBytes.toDouble();
  num count; //1KB
  String suffix = "";
  for (int i = 1; i <= 4; i++) {
    suffix = i == 1
        ? " o"
        : i == 2
            ? " Ko"
            : i == 3
                ? " Mo"
                : " Go";
    count = pow(1000, i);

    if (sizeInBytes < count) {
      size = size * 1000 / count;
      break;
    }
  }

  res = size.round().toString();
  return res + suffix;
}

String fileExt(String filename) {
  if (!filename.contains(".")) return "";
  return filename.split(".").last;
}

IconData main_icondata = Icons.phone_android;
String main_title = "";
double main_usedSpace = 0;
double main_freeSpace = 0;

class InternalStorage extends StatefulWidget {
  @override
  InternalStorageState createState() => InternalStorageState(path);
  final IconData icondata;
  final String title;
  final double usedSpace;
  final double freeSpace;
  final String path;

  List<FileSystemEntity> entities = [];

  // ignore: use_key_in_widget_constructors
  InternalStorage(
      this.icondata, this.title, this.usedSpace, this.freeSpace, this.path) {
    var st = Permission.storage.status;
    // var p = PermissionStatus.granted;
    main_icondata = icondata;
    main_title = title;
    main_usedSpace = usedSpace;
    main_freeSpace = freeSpace;
    st.isGranted.then((value) {
      print("Is storage granted ? " + value.toString());
    });
  }
}

class InternalStorageState extends State<InternalStorage> {
  bool isItemsLoaded = false;
  bool bottomShow = false;
  List<Widget> itemsList = [];
  String path;
  List<String> selectedPath = [];

  bool get moreThanOne {
    return selectedPath.length > 1;
  }

  bool get itemSelected {
    return selectedPath.isNotEmpty;
  }

  InternalStorageState(this.path) {
    pathList();
  }

  FutureOr onGoBack(dynamic value) {
    pathList();
  }

  final List allItems = [];
  Future<bool> isPermissionGranted() async {
    var status = await Permission.storage.request();

    return status.isGranted;
  }

  void pathList() {
    reqPerm().then((value) {
      allItems.clear();

      List<String>? ls = ItemsCache.cached[path];
      if (ls != null) {
        allItems.addAll(ls);
        allItems.sort();
        initItemsList();
        setState(() {
          isItemsLoaded = true;
        });
        return;
      }
      final directory = Directory(path);
      Map<String, List<String>> m = {path: []};

      directory.list().toList().then(
        (value) {
          value.forEach(
            (element) {
              allItems.add(element.toString());
              m[path]?.add(element.toString());
            },
          );
          ItemsCache.cached.addAll(m);
          // print("On a " + ItemsCache.cached.toString());
          allItems.sort();
          initItemsList();
          setState(() {
            isItemsLoaded = true;
          });
        },
      );
    });
  }

  void initItemsList() {
    //print(path);
    itemsList.clear();
    for (var element in allItems) {
      int index = allItems.indexOf(element);
      String name = element
          .toString()
          .split(Platform.pathSeparator)
          .last
          .split("'")
          .first;
      Directory d = Directory(path + name);
      File f = File(path + name);

      // print("trouvé " + path + name);
      if (!d.existsSync() && !f.existsSync()) continue;
      itemsList.add(
        d.existsSync()
            ? folderCard(
                name: name,
                parentPath: path,
                itemsCount: d.listSync().length,
              )
            : fileCard(
                name: name,
                icondata: extAndIcon[fileExt(name)] ?? Icons.file_copy_rounded,
                parentPath: path,
                size: perfectSize(f.lengthSync()),
                lastDate: f.lastAccessedSync().toString().split(" ").first,
                color: extAndCol[fileExt(name)] ?? crgb(100, 100, 100),
              ),
      );
    }
  }

  void deleteCacheForPath() {
    List<String>? ls = ItemsCache.cached[path];
    if (ls != null) {
      ItemsCache.cached.remove(path);
    }
  }

  void createFile(String name) {
    if (name.isEmpty) return;
    File f = File(path + name);
    f.createSync(recursive: true);
    deleteCacheForPath();
    pathList();
    GetStorageItems.init();
  }

  void createFolder(String name) {
    Directory d = Directory(path + name);
    d.createSync(recursive: true);
    deleteCacheForPath();
    pathList();
    GetStorageItems.init();
  }

  bool atLeastOneItemIsSelected() {
    return selectedPath.isNotEmpty;
  }

  void newItemSelected(String itemName) {
    setState(() {
      selectedPath.add(path + itemName);
      bottomShow = true;
      initItemsList();
    });
    print(selectedPath);
  }

  void anItemDeselected(String itemName) {
    setState(() {
      selectedPath.remove(path + itemName);

      if (selectedPath.isEmpty) {
        bottomShow = false;
      }
      initItemsList();
    });
    print(selectedPath);
  }

  Widget folderCard({
    required String name,
    required String parentPath,
    required int itemsCount,
  }) {
    return FolderCard(
      name: name,
      parentPath: parentPath,
      itemsCount: itemsCount,
      selectItem: newItemSelected,
      deselectItem: anItemDeselected,
      oneIsSelected: itemSelected,
      onGoBack: onGoBack,
    );
  }

  Widget fileCard({
    required String name,
    required IconData icondata,
    required String parentPath,
    required String size,
    required String lastDate,
    required color,
  }) {
    return FileCard(
      name: name,
      parentPath: parentPath,
      icondata: icondata,
      size: size,
      lastDate: lastDate,
      color: color,
      selectItem: newItemSelected,
      deselectItem: anItemDeselected,
      oneIsSelected: itemSelected,
      onGoBack: onGoBack,
    );
  }

  void selectAll() {
    itemsList.forEach((element) {});
    print(allItems.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 247, 250, 1),
      appBar: InternalStorageAppBar(),
      body: Column(
        children: [
          Column(
            children: [
              IDStorageCard(
                icondata: widget.icondata,
                title: widget.title,
                usedSpace: widget.usedSpace,
                freeSpace: widget.freeSpace,
              ),
              // dans la column princapal
              Header(
                nbSelected: selectedPath.length,
                nbItems: itemsList.length,
                isSelected: itemSelected,
                selectAll: selectAll,
                createFile: createFile,
                createFolder: createFolder,
              ),
            ],
          ),
          (isItemsLoaded && allItems.isNotEmpty)
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: itemsList,
                    ),
                  ),
                )
              : (isItemsLoaded && allItems.isEmpty)
                  ? Expanded(
                      child: oups(),
                    )
                  : Center(child: CircularProgressIndicator()),
          if (!bottomShow) Gap(20),
        ],
      ),
      bottomNavigationBar: bottomShow
          ? BottomNavigationBar(
              selectedItemColor: crgb(100, 100, 100),
              unselectedItemColor: crgb(100, 100, 100),
              showUnselectedLabels: true,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: (index) {
                if (moreThanOne) {
                  switch (index) {
                    case 0:
                      deleteItem();
                      break;

                    case 1:
                      shareItem(selectedPath.last);
                      break;

                    case 2:
                      //TODO ("Plus")
                      break;
                  }
                } else {
                  switch (index) {
                    case 0:
                      String newname = "";
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Icon(Icons.edit_rounded),
                              actions: [
                                TextButton(
                                  child: Text('Renommer'),
                                  onPressed: () {
                                    if (newname == "") return;
                                    renameItem(newname);
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ],
                              content: TextField(
                                onChanged: (value) {
                                  newname = value;
                                },
                                decoration:
                                    InputDecoration(hintText: "Nom du fichier"),
                              ),
                            );
                          });
                      break;

                    case 1:
                      deleteItem();
                      break;

                    case 2:
                      shareItem(selectedPath.last);
                      break;
                    case 3:
                      //TODO ("Plus")
                      break;
                  }
                }
              },
              items: [
                if (!moreThanOne)
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit_rounded),
                    label: "Renommer",
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.delete),
                  label: "Supprimer",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.share_rounded),
                  label: "Partager",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz_rounded),
                  label: "Plus",
                ),
              ],
            )
          : null,
    );
  }

  Future<bool> deleteAllSelected() async {
    bool ret = false;

    for (var element in selectedPath) {
      File f = File(element);
      Directory d = Directory(element);
      ret = false;
      if (f.existsSync()) {
        await f.delete();
        setState(() {
          pathList();
        });
        ret = true;
      } else if (d.existsSync()) {
        if (d.listSync().isEmpty) {
          await d.delete();
          setState(() {
            pathList();
          });
          ret = true;
          continue;
        }
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Répertoire non vide'),
                actions: [
                  TextButton(
                    child: Text('Annuler'),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  TextButton(
                    child: Text('Supprimer'),
                    onPressed: () {
                      d.delete(recursive: true);

                      ret = true;
                      setState(() {
                        Navigator.pop(context);
                        deleteCacheForPath();

                        pathList();
                      });
                    },
                  ),
                ],
                content: Text(d.path.split(Platform.pathSeparator).last +
                    " contient " +
                    d.listSync().length.toString() +
                    " éléments"),
              );
            });
      }
    }
    return ret;
  }

  Future<void> renameSelected(String newnme) async {
    if (selectedPath.isEmpty) return;
    var element = selectedPath[0];

    File f = File(element);
    if (f.existsSync()) {
      await f.rename(path + newnme);
      setState(() {
        selectedPath = [];
        bottomShow = false;
      });
    }
  }

  void renameItem(String s) {
    renameSelected(s).then((value) {
      setState(() {
        selectedPath = [];
        bottomShow = false;
        deleteCacheForPath();
        pathList();
      });
    });
  }

  void deleteItem() {
    deleteAllSelected().then((value) {
      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Suppression..."),
          duration: Duration(milliseconds: 500),
        ));

        setState(() {
          selectedPath = [];
          bottomShow = false;
          deleteCacheForPath();

          //pathList();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Terminé "),
          duration: Duration(milliseconds: 300),
        ));
        GetStorageItems.init();
      }
    });
  }

  void shareItem(String path) {
    FlutterShare.shareFile(
      title: "Fichier " + path.split(Platform.pathSeparator).last,
      text: "Partagez vos fichiers avec FM Explorer",
      //fileType: '*/.mp3',
      filePath: path,
      chooserTitle: "Partager " + path.split(Platform.pathSeparator).last,
    );
  }
}

Widget FolderCard({
  required String parentPath,
  required String name,
  required int itemsCount,
  required selectItem,
  required onGoBack,
  required deselectItem,
  required oneIsSelected,
}) {
  return ItemsCard(
    icondata: Icons.folder,
    name: name,
    isFolder: true,
    parentPath: parentPath,
    itemsCount: itemsCount,
    activeSelectItem: selectItem,
    onGoBack: onGoBack,
    deactiveSelectItem: deselectItem,
    oneIsSelected: oneIsSelected,
  );
}

Widget FileCard({
  required String parentPath,
  required String name,
  required IconData icondata,
  required String size,
  required String lastDate,
  required color,
  required selectItem,
  required onGoBack,
  required deselectItem,
  required oneIsSelected,
}) {
  return ItemsCard(
    icondata: icondata,
    name: name,
    isFolder: false,
    parentPath: parentPath,
    size: size,
    date: lastDate,
    color: color,
    activeSelectItem: selectItem,
    deactiveSelectItem: deselectItem,
    oneIsSelected: oneIsSelected,
    onGoBack: onGoBack,
  );
}
