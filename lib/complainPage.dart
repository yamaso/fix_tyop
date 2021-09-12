import 'package:fix_tyop/start_up.dart';
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
      backgroundColor: Color(0xFF2C344F),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'ねれない人が悲しむ場所',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF1D213F),
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
                  color: Color(0xFF2C344F),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'あまえんぼうに言いたいこと',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: complaintTextController,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLength: 140,
                        maxLines: 10,
                        minLines: 1,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                          hintText: '(例)こっちは徹夜なのに, 起きんかい！',
                          hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white54,
                              fontWeight: FontWeight.w400),
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
                              primary: Colors.white70,
                              onPrimary: Colors.grey,
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
        "https://app.fuji8.me/dialogues?dayOfWeek=$dayOfWeek&order=$order");
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

      _registDialoges("MONDAY", 5, complaintTextController.text);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => StartUpPage(title: 'GoToSleep')),
        (_) => false,
      );

      _loading = false;
    }
  }
}
