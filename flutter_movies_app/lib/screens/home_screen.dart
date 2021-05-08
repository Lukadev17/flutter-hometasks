import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/models/movie_model.dart';
import 'package:flutter_movies_app/data/repository/movie_helper.dart';
import 'package:flutter_movies_app/widgets/main_list_item.dart';
import 'package:provider/provider.dart';
import 'add_new_movie_screen.dart';
import 'edit_movie_screen.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  // void getRecentlyAdded(List<Movie> movieList) {
  //   movieList = movieList.where((element) => element.category == "RecentlyAdded")
  //       .toList();
  // }
  //
  // void getMyFavorites(List<Movie> movieList) {
  //   movieList = movieList.where((element) => element.category == "MyFavorites")
  //       .toList();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              TextButton(
                onPressed: () {
                  Provider.of<MovieRepository>(context, listen: false).getRecentlyAdded();
                },
                child: Text("Recently Added"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Provider.of<MovieRepository>(context, listen: false).getMyFavorites();
                },
                child: Text("My Favorites"),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  Provider.of<MovieRepository>(context, listen: false).reset();
                },
                child: Text("Reset"),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Consumer<MovieRepository>(
          builder: (BuildContext context, movies, Widget child) {
            var movieList = movies.moviesList;
            if (movies.recently == true) {
              movieList = movieList.where((element) => element.category == "RecentlyAdded")
                  .toList();
            } else if (movies.favorites == true) {
              movieList = movieList.where((element) => element.category == "MyFavorites")
                  .toList();
            }
            return ListView.builder(
              itemBuilder: (ctx, index) {
                var movie = movieList[index];
                return Dismissible(
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MovieDetailsScreen.routeName,
                          arguments: movie);
                    },
                    onLongPress: () {
                      Navigator.pushNamed(
                        context,
                        EditMovieScreen.routeName,
                        arguments: {"movie": movie, "index": index},
                      );
                    },
                    child: MainListItem(
                      imageUrl: movie.imageUrl,
                      title: movie.name,
                      releaseDate: movie.releaseDate.toString(),
                      rating: movie.rating.toString(),
                    ),
                  ),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Are you sure?"),
                        content: Text("Do you really want to delete this movie?"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("NO")),
                          TextButton(
                              onPressed: () {
                                movies.removeMovie(movie.id);
                                Navigator.pop(context);
                              },
                              child: Text("YES")),
                        ],
                      )),
                );
              },
              itemCount: movieList.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewMovieScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}