import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/dummy_data.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';

class MovieRepository extends ChangeNotifier{
  bool recently, favorites = false;
  List<Movie> moviesList = [];

  void addMovie(Movie movie){
    moviesList.add(movie);
    notifyListeners();
  }

  void removeMovie(int id){
    DUMMY_DATA.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void editMovie(Movie movie) {
    for (var i = 0; i < moviesList.length; i++) {
      if (moviesList[i].id == movie.id) {
        moviesList.replaceRange(i, i + 1, [movie]);
        break;
      }
    }
    notifyListeners();
  }

  void getRecentlyAdded() {
    recently = true;
    favorites = false;
    notifyListeners();
  }

  void getMyFavorites() {
    recently = false;
    favorites = true;
    notifyListeners();
  }

  void reset() {
    recently = false;
    favorites = false;
    notifyListeners();
  }

}