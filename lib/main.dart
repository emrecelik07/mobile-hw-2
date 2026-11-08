import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3366CC),
          primary: const Color(0xFF3366CC),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
