import 'package:just_audio/just_audio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PlaySound {
  static Future<void> playSound(String dayOfWeek, int order) async {
    Uri url = Uri.parse(
        "https://app.fuji8.me/audios?dayOfWeek=$dayOfWeek&order=$order");
    Map<String, String> headers = {'content-type': 'audio/mpeg'};
    http.Response resp = await http.get(url, headers: headers);
    print(resp.statusCode);
    if (resp.statusCode != 200) {
      print("hogehgehgoafl;kdsjfkldsa");
    }

    getFilePath().then((File file) {
      file.writeAsBytes(resp.bodyBytes);
    });

    final directory = await getTemporaryDirectory();
    final player = AudioPlayer();
    await player.setFilePath(directory.path + '/sound.mp3');
    player.play();
  }

  static Future<File> getFilePath() async {
    final directory = await getTemporaryDirectory();
    return File(directory.path + '/sound.mp3');
  }

  static Future<void> playSound2(String dayOfWeek, int order) async {
    Uri url = Uri.parse(
        "https://app.fuji8.me/audios?dayOfWeek=$dayOfWeek&order=$order");
    Map<String, String> headers = {'content-type': 'audio/mpeg'};
    http.Response resp = await http.get(url, headers: headers);
    print(resp.statusCode);
    if (resp.statusCode != 200) {
      print("hogehgehgoafl;kdsjfkldsa");
    }

    getFilePath2().then((File file) {
      file.writeAsBytes(resp.bodyBytes);
    });

    final directory = await getTemporaryDirectory();
    final player = AudioPlayer();
    await player.setFilePath(directory.path + '/sound2.mp3');
    player.play();
  }

  static Future<File> getFilePath2() async {
    final directory = await getTemporaryDirectory();
    return File(directory.path + '/sound2.mp3');
  }
}
