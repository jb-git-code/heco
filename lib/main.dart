import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heco/firebase_options.dart';
import 'screens/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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