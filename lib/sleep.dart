import 'package:fix_tyop/services/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'package:fix_tyop/playSound.dart';
import 'package:just_audio/just_audio.dart';

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
      Timer.periodic(Duration(minutes: 45), (timer) async {
        await PlaySound.playSound("MONDAY", 1);
      });
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    Timer.periodic(Duration(seconds: 30), _onTimer);
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    if (now.difference(widget.deadLine).inMinutes <= 60) {
      print("アラーム");
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
                SizedBox(height: 60),
                ScaleTransition(
                  scale: animationController.drive(
                    Tween<double>(
                      begin: 1.0,
                      end: 1.05,
                    ),
                  ),
                  child: Image.asset(
                    'images/aoi_n_sleep.png',
                    width: 200,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
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

  static Future<DateTime> timer(BuildContext context, DateTime _currentTime) {
    return DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      currentTime: _currentTime,
      locale: LocaleType.jp,
    ).then((time) => time ?? _currentTime);
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    animationController.dispose();
    super.dispose();
  }
}
