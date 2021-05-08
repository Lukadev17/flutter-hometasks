import 'package:flutter/material.dart';

class MainListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String releaseDate;
  final String rating;

  MainListItem({this.imageUrl, this.title, this.releaseDate, this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: FadeInImage(
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/images/image_placeholder.jpg"),
                image: NetworkImage(imageUrl),
              ),
            ),
            Text(title),
            Text(releaseDate)
          ],
        ),
      ),
    );
  }
}
