import 'package:flutter/cupertino.dart';

class ItemsCache {
  static Map<String, List<String>> cached = {};
  static int itemsLimit = 999999;
  static BuildContext? context;
}
