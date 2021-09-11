import 'package:flutter/material.dart';
import 'services/background.dart';
import 'services/outlinedButton.dart';
import 'goto_bed.dart';

class StartUpPage extends StatefulWidget {
  StartUpPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          getBackgroud(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 160,
                  ),
                  child: Text('Title的な'),
                ),
                getOutlinedButton(0x7a9cbaff, '寝る', () {
                  GoToSleepPage(title: 'GoToSleep');
                }),
                getOutlinedButton(0x7a9cbaff, '寝ない', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
