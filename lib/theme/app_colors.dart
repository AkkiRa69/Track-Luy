import 'package:flutter/material.dart';

class AppColors {
  static const contentColorYellow = Color(0xFFFFEB3B); // Yellow color
  static const contentColorRed = Color(0xFFF44336); // Red color
  static const contentColorOrange = Color(0xFFFF9800); // Orange color
  static const primary = Color(0xFF6200EA); // Purple color as an example
  static const contentColorPink = Color(0xFFE91E63); // Pink color
  static const contentColorGreen = Color(0xFF4CAF50); // Green color
  static const contentColorCyan = Color(0xFF00BCD4); // Cyan color
  static const mainGridLineColor =
      Color(0xFF70db79); // Replace with desired color value
  static const contentColorBlue = Color(0xff38bcf9);

  //app color
  static const backGround = Color(0xff000000);
  static const kindaBlack = Color(0xff1f212e);
  static const grey = Color(0xff5e5e67);
  static const text = Color(0xff7f7f7f);
  static const contentColorWhite = Color(0xffffffff);

  static const blue = Color(0xff3a43f2);
  static const green = Colors.green;
  static const red = Colors.red;
}

extension ColorExtension on Color {
  Color avg(Color other) {
    int r = ((red + other.red) / 2).round();
    int g = ((green + other.green) / 2).round();
    int b = ((blue + other.blue) / 2).round();
    int a = ((alpha + other.alpha) / 2).round();
    return Color.fromARGB(a, r, g, b);
  }

  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final darkenedHsl =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkenedHsl.toColor();
  }
}
