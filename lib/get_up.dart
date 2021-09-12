import 'dart:async';

import 'package:fix_tyop/services/alert_dialog.dart';
import 'package:fix_tyop/services/background.dart';
import 'package:fix_tyop/start_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fix_tyop/playSound.dart';
import 'package:page_transition/page_transition.dart';

class GetUpPage extends StatefulWidget {
  GetUpPage({Key? key, required this.deadLine}) : super(key: key);

  final DateTime deadLine;

  @override
  _GetUpPageState createState() => _GetUpPageState();
}

class _GetUpPageState extends State<GetUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late DateTime time;
  late PlaySound ps;
  var aoi = 'images/aoi_a_ki.png';

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    ps = PlaySound();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    Future(() async {
      await PlaySound.playSound("MONDAY", 2);
      new Timer(const Duration(seconds: 20), () async {
        await PlaySound.playSound2("MONDAY", 3);
        setState(() {
          aoi = 'images/aoi_n_sad.png';
        });
      });
    });
    Timer.periodic(Duration(seconds: 35), _onTimer);
  }

  void _onTimer(Timer timer) async {
    var now = DateTime.now();
    if (now.difference(widget.deadLine).inMinutes <= 5) {
      await PlaySound.playSound("MONDAY", 4);
      setState(() {
        aoi = 'image/aoi_a.png';
      });
      await AlermDialog.show(context, widget.deadLine);
      new Timer(const Duration(seconds: 20), () async {
        await PlaySound.playSound("MONDAY", 5);
        setState(() {
          aoi = 'images/aoi_a_do.png';
        });
      });
    }
    setState(() {
      time = now;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          getBackgroud(),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Text(
                    time.hour.toString() + '：' + time.minute.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 100.0),
                  ElevatedButton(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/sun_button.png"),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      shape: const CircleBorder(),
                      elevation: 30.0,
                    ),
                    onPressed: () async {
                      await PlaySound.playSound("MONDAY", 6);
                      setState(() {
                        aoi = 'images/aoi_a_ki.png';
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          PageTransition(
                            child: StartUpPage(title: ''),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 4000),
                          ),
                          (_) => false);
                    },
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ScaleTransition(
                    scale: animationController.drive(
                      Tween<double>(
                        begin: 1.0,
                        end: 1.05,
                      ),
                    ),
                    child: Image.asset(
                      aoi,
                      width: 180,
                      height: 580,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
