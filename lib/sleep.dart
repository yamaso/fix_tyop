import 'package:fix_tyop/services/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'package:fix_tyop/playSound.dart';
import 'package:just_audio/just_audio.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
      await _player.setVolume(0.5);
      _player.play();
      Timer.periodic(Duration(seconds: 30), (timer) async {
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
                    'images/aka_n_sleep.png',
                    width: 200,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
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
}
