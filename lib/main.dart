import 'package:flutter/material.dart';
import './pages/home.dart';
import 'contants.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FM Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF00C4FE, color),
      ),
      home: const Home(),

    );
  }
}
