import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _content = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _request() async {
    Uri url = Uri.parse("https://httpbin.org/post");
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'name': 'moke'});

    http.Response resp = await http.post(url, headers: headers, body: body);
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
        _content = "Failed to post $statusCode";
      });
      return;
    }
    setState(() {
      _content = resp.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(onPressed: _request, child: Text('httpテスト')),
            Text(_content),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
