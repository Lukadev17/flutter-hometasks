import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;

  MainListItem({this.imageUrl, this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: FadeInImage(
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                placeholder:
                    AssetImage("assets/images/clothes_placeholder.png"),
                image: NetworkImage(imageUrl),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: [Text(name), Text(price)],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
