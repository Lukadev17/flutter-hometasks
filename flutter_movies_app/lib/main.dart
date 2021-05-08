import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repository/movie_helper.dart';
import 'package:flutter_movies_app/screens/add_new_movie_screen.dart';
import 'package:flutter_movies_app/screens/edit_movie_screen.dart';
import 'package:flutter_movies_app/screens/home_screen.dart';
import 'package:flutter_movies_app/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MovieRepository(),
      child: MaterialApp(
        title: 'Movies App',
        theme: ThemeData(
            accentColor: Colors.purpleAccent,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purpleAccent),
                )
            )
        ),
        home:HomeScreen(),
        routes: {
          MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
          AddNewMovieScreen.routeName: (context) => AddNewMovieScreen(),
          EditMovieScreen.routeName: (context) => EditMovieScreen(),
        },
      ),
    );
  }
}
