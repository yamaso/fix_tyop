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
  late AnimationController animationController2;
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time.hour.toString() + '：' + time.minute.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 20.0),
              ScaleTransition(
                scale: animationController2.drive(
                  Tween<double>(
                    begin: 1,
                    end: 1.10,
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/sleep_button.png"),
                    ),
                  ),
                  child: ElevatedButton(
                    child: Text(''),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ScaleTransition(
                scale: animationController.drive(
                  Tween<double>(
                    begin: 1,
                    end: 1.10,
                  ),
                ),
                child: Image.asset(
                  'images/aka_a.png',
                  width: 100,
                  height: 300,
                  fit: BoxFit.cover,
                ),
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
