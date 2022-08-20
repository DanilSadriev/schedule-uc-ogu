import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// цвета
abstract class DarkThemeColors {
  static const background = Color(0xFF0F0E13);
  static const gray = Color(0xFF303239);
  static const lightGray = Color(0xFF2A2A2A);
  static const text = Color(0xFFBEBEBE);
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF1F57E7);
  static const green = Color(0xFF027600);
  static const red = Color(0xFFBA2A00);
}

abstract class LightThemeColors {
  static const background = Color(0xFFFFFFFF);
  static const gray = Color(0xFF9999A3);
  static const lightGray = Color(0xFFEFF1F7);
  static const text = Color(0xFF000118);
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF2F69FE);
  static const green = Color(0xFF14B411);
  static const red = Color(0xFFF24E1E);
}
