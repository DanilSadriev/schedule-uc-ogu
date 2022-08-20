import 'package:flutter/material.dart';

class LessonCardUtils {
  Color getColorsAudience(String audience) {
    String floor = audience.substring(1, 2);
    if (floor == '1') {
      return const Color(0xFF667EEA);
    } else if (floor == '2') {
      return const Color(0xFFFF7082);
    } else if (floor == '3') {
      return const Color(0xFF96E6A1);
    } else {
      return const Color(0xFF71C5EE);
    }
  }
}
