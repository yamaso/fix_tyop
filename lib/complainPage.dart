import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class SendAllNightUserComplaintPage extends StatefulWidget {
  SendAllNightUserComplaintPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _SendAllNightUserComplaintPageState createState() =>
      _SendAllNightUserComplaintPageState();
}

class _SendAllNightUserComplaintPageState
    extends State<SendAllNightUserComplaintPage> {
  TextEditingController complaintTextController = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'ねれない人が悲しむ場所',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '言いたいこと',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextFormField(
                        controller: complaintTextController,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLength: 20,
                        decoration: InputDecoration(
                          hintText: 'おきろや',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: (complaintTextController.text.isNotEmpty)
                                ? submitPressed
                                : null,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              '登録',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(30.0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registDialoges(String dayOfWeek, int order, String dialogue) async {
    Uri url = Uri.parse(
        "http://192.168.0.9:1234/dialogues?dayOfWeeek=$dayOfWeek&order=$order");
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'dialogue': dialogue});

    http.Response resp = await http.post(url, headers: headers, body: body);
    if (resp.statusCode != 204) {
      print("hogehgehgoafl;kdsjfkldsa");
      return;
    }
  }

  void submitPressed() async {
    if (complaintTextController.text.isNotEmpty &&
        complaintTextController.text.length < 21) {
      setState(() {
        _loading = true;
      });

      _registDialoges("Monday", 1, complaintTextController.text);

      _loading = false;
    }
  }
}
