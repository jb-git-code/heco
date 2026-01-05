import 'package:flutter/material.dart';

class ColorUtils {
  static List<int> materialShades = [
    50, 100, 200, 300, 400, 500, 600, 700, 800, 900
  ];

  static List<Color> generateMaterialPalette(MaterialColor color) {
    return materialShades
        .map((shade) => color[shade]!)
        .toList();
  }

  static String toHex(Color color) {
    return '#'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}