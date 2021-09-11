import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistDialogues {
  static void registDialoges(
      String dayOfWeek, int order, String dialogue) async {
    Uri url = Uri.parse("いい感じURL?dayOfWeeek=$dayOfWeek&order=$order");
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({'dialogue': dialogue});

    http.Response resp = await http.post(url, headers: headers, body: body);
    if (resp.statusCode != 204) {
      print("hogehgehgoafl;kdsjfkldsa");
      return;
    }
  }
}
