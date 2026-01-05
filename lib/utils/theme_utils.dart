import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData buildTheme(List<Color> colors, {required bool isDark}) {
    final primary = colors[0];
    final secondary = colors.length > 1 ? colors[1] : colors[0];
    final background = colors.length > 2
        ? colors[2]
        : (isDark ? Colors.black : Colors.white);
    final surface = colors.length > 3
        ? colors[3]
        : (isDark ? const Color(0xFF1E1E1E) : Colors.white);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,

        primary: primary,
        onPrimary: _onColor(primary),

        secondary: secondary,
        onSecondary: _onColor(secondary),

        background: background,
        onBackground: _onColor(background),

        surface: surface, // ✅ 4th color used here
        onSurface: _onColor(surface),

        error: Colors.red,
        onError: Colors.white,
      ),
    );
  }

  static String exportFlutterTheme(List<Color> colors) {
    String hex(Color c) =>
        '0xFF${c.value.toRadixString(16).substring(2).toUpperCase()}';

    return '''
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Color(${hex(colors[0])}),
    secondary: Color(${hex(colors[1])}),
    background: Color(${hex(colors.length > 2 ? colors[2] : Colors.white)}),
  ),
);
''';
  }

  static Color _onColor(Color bg) {
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
