// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

Color crgb(int r, int g, int b) {
  return Color.fromRGBO(r, g, b, 1);
}

var col_pht = crgb(255, 148, 75);
var col_vid = crgb(255, 70, 90);
var col_doc = crgb(27, 139, 248);
var col_aud = crgb(0, 218, 153);
var col_rch = crgb(179, 89, 247);
var col_zip = crgb(0, 195, 54);

Map<String, IconData> extAndIcon = {
  "jpg": Icons.photo_library,
  "png": Icons.photo_library,
  "jpeg": Icons.photo_library,
  "mp3": Icons.library_music,
  "wav": Icons.library_music,
  "3gp": Icons.video_library,
  "aac": Icons.video_library,
  "apk": Icons.android_rounded,
  "mp4": Icons.video_library,
  "gif": Icons.video_library,
  "mkv": Icons.video_library,
  "html": Icons.web,
  "htm": Icons.web,
  "docx": Icons.library_books,
  "doc": Icons.library_books,
  "css": Icons.style,
  "js": Icons.code_rounded,
};

Map<String, Color> extAndCol = {
  "apk": col_zip,
  "jpg": col_pht,
  "png": col_pht,
  "jpeg": col_pht,
  "mp3": col_aud,
  "wav": col_aud,
  "3gp": col_vid,
  "aac": col_vid,
  "mp4": col_vid,
  "gif": col_vid,
  "mkv": col_vid,
  "html": col_zip,
  "htm": col_zip,
  "docx": col_doc,
  "doc": col_doc,
  "css": col_doc,
  "js": col_pht,
};

Map<String, List<String>> textAndType = {
  "images": [
    "jpg",
    "png",
    "jpeg",
  ],
  "vidéos": [
    "3gp",
    "aac",
    "mkv",
    "mp4",
    "gif",
  ],
  "audios": [
    "mp3",
    "wav",
  ],
  "documents": [
    "doc",
    "docx",
    "html",
    "htm",
    "css",
    "js",
  ],
  "autres": [
    "",
    " ",
    "apk",
    "cpp",
    "cxx",
  ],
  "fichiers": [
    "jpg",
    "png",
    "jpeg",
    "3gp",
    "aac",
    "mkv",
    "mp4",
    "gif",
    "mp3",
    "wav",
    "doc",
    "docx",
    "html",
    "htm",
    "css",
    "js",
    "",
    " ",
    "apk",
    "cpp",
    "cxx",
  ],
};

Widget oups() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 170,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/empty.png"),
              scale: .7,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Text(
          "Oups.. Aucun élément à afficher",
          style: GoogleFonts.dmSans(
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ],
    ),
  );
}
