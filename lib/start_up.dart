import 'package:flutter/material.dart';
import 'complainPage.dart';
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
                  margin: EdgeInsets.fromLTRB(48, 136, 16, 64),
                  child: Container(
                      width: 336,
                      height: 280,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/logo.png"),
                        ),
                      )
                  )
                ),
                getOutlinedButton(0x7a9cbaff, '寝る', () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            GoToSleepPage(title: 'GoToSleep')),
                    (_) => false,
                  );
                }),
                SizedBox(height: 7.0),
                getOutlinedButton(0x7a9cbaff, '寝られない', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SendAllNightUserComplaintPage(title: 'ComplaintPage'),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
