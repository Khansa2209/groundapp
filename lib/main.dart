import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PitchGo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  SplashScreen(), // SplashScreen added here
      debugShowCheckedModeBanner: false, // Optional: Removes the debug banner
    );
  }
}
