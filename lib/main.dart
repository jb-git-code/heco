import 'package:flutter/material.dart';
import 'screens/root_screen.dart';

void main() {
  runApp(const ColorHelperApp());
}

class ColorHelperApp extends StatelessWidget {
  const ColorHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HECO',
      theme: ThemeData(useMaterial3: true),
      home: const RootScreen(),
    );
  }
}