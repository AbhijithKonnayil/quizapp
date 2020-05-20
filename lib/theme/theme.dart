import 'package:flutter/material.dart';

class QuizAppTheme {
  static Color blue3 = Color(0xFF013a68);
  static Color blue2 = Color(0xFF01579b);
  static Color blue1 = Color(0xFF29b6f6);
  static Color blue0 = Color(0xFF54c5f8);

  static Gradient blueShade32 = LinearGradient(
      colors: <Color>[blue3, blue2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static Gradient blueShade30 = LinearGradient(
      colors: <Color>[blue3, blue0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static Gradient blueShade31 = LinearGradient(
      colors: <Color>[blue3, blue1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static Gradient blueShade21 = LinearGradient(
      colors: <Color>[blue2, blue1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static Gradient blueShade20 = LinearGradient(
      colors: <Color>[blue2, blue1],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static Gradient blueShade10 = LinearGradient(
      colors: <Color>[blue1, blue0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
