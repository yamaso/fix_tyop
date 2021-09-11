import 'package:flutter/material.dart';

class AlermDialog {
  static Future<void> show(BuildContext context, String text) async {
    const int color = 0x1D213FFF;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '起きますか？',
            style: TextStyle(color: Color(color)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(color: Color(color)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              SizedBox(height: 16),
              TextButton(
                child: const Text('起きました！'),
                onPressed: () {
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
