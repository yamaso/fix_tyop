import 'package:just_audio/just_audio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PlaySound {
  static void playSound(String dayOfWeek, int order) async {
    Uri url = Uri.parse("いい感じURL?dayOfWeeek=$dayOfWeek&order=$order");
    http.Response resp = await http.get(url);
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
}
