import 'package:flutter/material.dart';
import 'package:solar_system/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Solar System",
      home: HomeScreen(),
    );
  }
}

