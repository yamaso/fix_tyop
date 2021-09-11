import 'package:fix_tyop/sleep.dart';
import 'package:flutter/material.dart';
import 'get_up.dart';
import 'goto_bed.dart';
import 'start_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartUpPage(title: 'めいんページ'),
    );
  }
}
