import 'package:flutter/material.dart';

class GoToSleepPage extends StatefulWidget {
  GoToSleepPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _GoToSleepPageState createState() => _GoToSleepPageState();
}

class _GoToSleepPageState extends State<GoToSleepPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
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
      ),
    );
  }
}
