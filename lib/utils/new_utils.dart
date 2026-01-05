import 'package:flutter/material.dart';

class OldUtils {
  static String toHex(Color color) {
    return '#'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  static String toRGB(Color color) {
    return '${color.red}, ${color.green}, ${color.blue}';
  }

  static List<Color> generateMonochromePalette(Color base) {
    final hsl = HSLColor.fromColor(base);
    return List.generate(5, (index) {
      final lightness = (0.2 + index * 0.15).clamp(0.0, 1.0);
      return hsl.withLightness(lightness).toColor();
    });
  }
}