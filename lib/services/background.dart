import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

getBackgroud() {
  return Container(
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
  );
}
