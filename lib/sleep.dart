import 'package:fix_tyop/services/alert_dialog.dart';
import 'package:fix_tyop/services/background.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fix_tyop/playSound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';

import 'get_up.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key, required this.deadLine}) : super(key: key);

  final DateTime deadLine;

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late DateTime time;
  AudioPlayer _player = AudioPlayer();
  var _timer;

  var aoi = 'images/aoi_n_sleep.png';

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    Future(() async {
      await _player.setAsset('assets/sleep.mp3');
      await _player.setVolume(0.1);
      await _player.setLoopMode(LoopMode.one);
      Timer(const Duration(seconds: 6), () {
        _player.play();
      });
      _timer = Timer.periodic(Duration(seconds: 20), (timer) async {
        await PlaySound.playSound("MONDAY", 1);
        setState(() {
          aoi = 'images/aoi_e_sleep.png';
        });
        Timer(const Duration(seconds: 2), () {
          setState(() {
            aoi = 'images/aoi_n_sleep.png';
          });
        });
      });
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    Timer.periodic(Duration(seconds: 30), _onTimer);
  }

  void _onTimer(Timer timer) async {
    var now = DateTime.now();
    if (now.difference(widget.deadLine).inMinutes <= 60) {
      _player.stop();
      await AlermDialog.show(context, widget.deadLine);
      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
            child: GetUpPage(deadLine: widget.deadLine),
            type: PageTransitionType.bottomToTop,
          ),
          (_) => false);
    }
    setState(() {
      time = now;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getBackgroud(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time.hour.toString() + '：' + time.minute.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 40),
                ScaleTransition(
                  scale: animationController.drive(
                    Tween<double>(
                      begin: 1.0,
                      end: 1.05,
                    ),
                  ),
                  child: Image.asset(
                    aoi,
                    width: 200,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'デッドライン【' +
                      widget.deadLine.hour.toString() +
                      '：' +
                      widget.deadLine.minute.toString() +
                      '】',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _player.dispose();
    animationController.dispose();
    super.dispose();
  }
}
