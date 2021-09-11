import 'package:flutter/material.dart';

getOutlinedButton(int color, String text, VoidCallback callback) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 8,
    ),
    width: 240,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(color),
        width: 3,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
    child: OutlinedButton(
      child: Text(text),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        primary: Color(color),
        padding: EdgeInsets.fromLTRB(40, 12, 40, 14),
        /*
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 8,
        ),*/
        shape: StadiumBorder(
            side: BorderSide(
          color: Color(color),
          width: 8.0,
        )),
        textStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        callback();
      },
    ),
  );
}
