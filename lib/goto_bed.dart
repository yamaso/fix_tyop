import 'package:fix_tyop/services/background.dart';
import 'package:fix_tyop/sleep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fix_tyop/playSound.dart';
import 'package:page_transition/page_transition.dart';

class GoToSleepPage extends StatefulWidget {
  GoToSleepPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _GoToSleepPageState createState() => _GoToSleepPageState();
}

class _GoToSleepPageState extends State<GoToSleepPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late DateTime time = DateTime.now();
  late PlaySound ps;

  @override
  void initState() {
    super.initState();
    ps = PlaySound();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Text(
                      time.hour.toString() + '：' + time.minute.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onTap: () async {
                      time = await timer(context, time);
                      setState(() {});
                    },
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
                          image: AssetImage("images/sleep_button.png"),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      shape: const CircleBorder(),
                      elevation: 30.0,
                    ),
                    onPressed: () async {
                      await PlaySound.playSound("MONDAY", 0);
                      Navigator.of(context).pushAndRemoveUntil(
                          PageTransition(
                            child: SleepPage(deadLine: time),
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
                      'images/aoi_a.png',
                      width: 150,
                      height: 500,
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
    animationController.dispose();
    super.dispose();
  }
}
