import 'package:fix_tyop/services/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class GoToSleepPage extends StatefulWidget {
  GoToSleepPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _GoToSleepPageState createState() => _GoToSleepPageState();
}

class _GoToSleepPageState extends State<GoToSleepPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
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
                  Text(
                    time.hour.toString() + '：' + time.minute.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
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
                          image: AssetImage("images/sleep_button.png"),
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<CircleBorder>(
                        CircleBorder(),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
              SizedBox(width: 40),
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
                      'images/aka_a.png',
                      width: 150,
                      height: 480,
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
}
