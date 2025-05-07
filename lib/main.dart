import 'package:flutter/material.dart';
import './splashscreens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyraa',
      debugShowCheckedModeBanner: false, // Removes the debug badge
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBE6992)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}