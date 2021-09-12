import 'dart:ui';

import 'package:fix_tyop/get_up.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';

AudioPlayer _player = AudioPlayer();

class AlermDialog {
  static Future<void> show(BuildContext context, DateTime deadLine) async {
    const int color = 0x1D213FFF;
    await _player.setAsset('assets/default_alerm.mp3');
    await _player.setVolume(0.6);
    await _player.setLoopMode(LoopMode.one);
    _player.play();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'アラーム！',
            style: TextStyle(color: Colors.black54),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/aoi_a_do.png',
                width: 400,
                height: 500,
                fit: BoxFit.contain,
              ),
              TextButton(
                child: const Text('アラームOFF'),
                onPressed: () {
                  _player.stop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
