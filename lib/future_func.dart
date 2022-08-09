// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:file_manager_app/helpers/items_cache.dart';
import 'package:file_manager_app/pages/home.dart';
import 'package:file_manager_app/widgets/storage_section.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

int counter = 0;
Timer? tim;
Future<List<String>> allPathInDir(String dir) async {
  List<String> allfiles = [dir];

  Directory currDir = Directory(dir);
  if (!currDir.existsSync()) {
    addUnique(dir, GetStorageItems.getAllFiles);
  } else {
    addUnique(dir, GetStorageItems.getAllFolders);

    List<FileSystemEntity> fl = await currDir.list().toList();
    for (var element in fl) {
      if (GetStorageItems.canLoad) {
        allfiles.addAll(await allPathInDir(element.path));
      }
    }
    allfiles.sort();
  }
  for (var element in allfiles) {
    addUnique(element, GetStorageItems.getAll);
  }
  GetStorageItems.sortAll();

  //Pour réduire le nombre de fichiers à charger
  if (GetStorageItems.length > ItemsCache.itemsLimit) {
    GetStorageItems.canLoad = false;
  }

  return allfiles;
}

Future<void> syncAllPath() async {
  await reqPerm();
  List<String> lp = await localPath;
  print("start");
  // GetStorageItems.clearAll();

  // GetStorageItems.canLoad = true;

  Timer(const Duration(seconds: 10), () {
    if (GetStorageItems.canLoad) {
      showDialog(
        context: ItemsCache.context!,
        builder: (context) {
          if (GetStorageItems.oldLength == GetStorageItems.length) {
            return AlertDialog(
              title: const Text("Le chargement est terminé"),
              content: Text(
                  GetStorageItems.length.toString() + " éléments chargés."),
              actions: [
                TextButton(
                  onPressed: () {
                    GetStorageItems.canLoad = false;
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          }
          GetStorageItems.oldLength = GetStorageItems.length;
          return AlertDialog(
            title: const Text("Le chargement a trop mis de temps"),
            content: Text(GetStorageItems.length.toString() +
                " éléments chargés. Vous pouvez passer le chargement."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // t.cancel();
                  syncAllPath();
                },
                child: Text("Continuer"),
              ),
              TextButton(
                onPressed: () {
                  GetStorageItems.canLoad = false;
                  Navigator.of(context).pop();
                },
                child: Text("Passer"),
              )
            ],
          );
        },
      );
    }
  });
  await allPathInDir(lp.first);
}

class GetStorageItems {
  static List<String> getAll = [];
  static List<String> getAllFiles = [];
  static List<String> getAllFolders = [];
  static bool canLoad = true;
  static int oldLength = 0;

  static get length {
    return getAll.length;
  }

  static get fileslength {
    return getAllFiles.length;
  }

  static get folderslength {
    return getAllFolders.length;
  }

  static void clearAll() {
    getAll.clear();
    getAllFiles.clear();
    getAllFolders.clear();
  }

  static void sortAll() {
    getAll.sort();
    getAllFiles.sort();
    getAllFolders.sort();
  }

  static void init() {
    print('finished ' +
        getAll.length.toString() +
        ' (' +
        getAllFolders.length.toString() +
        " et " +
        getAllFiles.length.toString() +
        ")");
  }
}

/// Insert [element] in the list [l] if it's not in yet
void addUnique(dynamic element, List l) {
  if (!l.contains(element)) {
    l.add(element);
  }
}
