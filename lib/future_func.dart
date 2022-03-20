import 'dart:io';

import 'package:file_manager_app/pages/home.dart';
import 'package:file_manager_app/widgets/storage_section.dart';

Future<List<String>> allPathInDir(String dir) async {
  List<String> allfiles = [dir];
  await reqPerm();

  Directory currDir = Directory(dir);
  if (!currDir.existsSync()) {
    addUnique(dir, GetStorageItems.getAllFiles);
  } else {
    addUnique(dir, GetStorageItems.getAllFolders);

    List<FileSystemEntity> fl = await currDir.list().toList();
    for (var element in fl) {
      if (GetStorageItems.canLoad)
        allfiles.addAll(await allPathInDir(element.path));
    }
    allfiles.sort();
  }
  for (var element in allfiles) {
    addUnique(element, GetStorageItems.getAll);
  }
  GetStorageItems.sortAll();
  //Pour réduire le nombre de fichiers à charger
  if (GetStorageItems.length > 100) GetStorageItems.canLoad = false;

  return allfiles;
}

Future<void> syncAllPath() async {
  List<String> lp = await localPath;
  GetStorageItems.clearAll();

  await allPathInDir(lp.first);
}

class GetStorageItems {
  static List<String> getAll = [];
  static List<String> getAllFiles = [];
  static List<String> getAllFolders = [];
  static bool canLoad = true;

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
