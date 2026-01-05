import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ColorHelperApp());
}

class ColorHelperApp extends StatelessWidget {
  const ColorHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}