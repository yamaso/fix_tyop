import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

getBackgroud() {
  return Container(
    child: Expanded(
      flex: 1,
      child: OverflowBox(
        maxHeight: double.infinity,
        alignment: Alignment.topCenter,
        child: Container(
          child: Lottie.asset(
            'assets/background.json',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
