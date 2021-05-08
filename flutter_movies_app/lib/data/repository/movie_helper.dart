import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';

class MovieRepository extends ChangeNotifier{
  bool recently = false;
  bool favorites = false;
  List<Movie> movieList = [];

  void addMovie(Movie movie){
    movieList.add(movie);
    notifyListeners();
  }

  void removeMovie(int id){
    movieList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void editMovie(Movie movie) {
    for (int i = 0; i < movieList.length; i++) {
      if (movieList[i].id == movie.id) {
        movieList.replaceRange(i, i + 1, [movie]);
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
    favorites = true;
    recently = false;
    notifyListeners();
  }

  void reset() {
    favorites = false;
    recently = false;
    notifyListeners();
  }
}