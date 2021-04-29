import 'package:flutter/material.dart';
import 'package:flutter_shualeduri/screens/add_new_clothes_screen.dart';
import 'package:flutter_shualeduri/screens/clothes_details_screen.dart';
import 'package:flutter_shualeduri/screens/edit_clothes_screen.dart';
import 'package:flutter_shualeduri/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shualeduri App',
      theme: ThemeData(
          accentColor: Colors.blueAccent,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              )
          )
      ),
      home: HomeScreen(),
      routes: {
        ClothesDetailsScreen.routeName: (context) => ClothesDetailsScreen(),
        AddNewClothesScreen.routeName: (context) => AddNewClothesScreen(),
        EditClothesScreen.routeName: (context) => EditClothesScreen(),
      },
    );
  }
}

