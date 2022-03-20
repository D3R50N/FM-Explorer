// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import '../contants.dart';

class SearchBar extends StatelessWidget {
  SearchBar(this.enabled, this.updateQuery, {Key? key}) : super(key: key);
  final bool enabled;
  Function(String query) updateQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          if (!enabled)
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
            ),
        ],
        borderRadius: BorderRadius.circular(!enabled ? 10 : 0),
      ),
      child: TextField(
        enabled: enabled,
        autofocus: enabled,
        enableSuggestions: true,
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 25),
            child: Icon(Icons.search),
          ),
          hintText: 'Rechercher un fichier',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: updateQuery,
      ),
    );
  }
}
