import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shualeduri/data/models/clothes_model.dart';
import 'package:flutter_shualeduri/data/repository/clothes_helper.dart';
import 'package:flutter_shualeduri/screens/home_screen.dart';

class ClothesDetailsScreen extends StatelessWidget {
  static const routeName = "/details-screen";

  @override
  Widget build(BuildContext context) {
    final Clothes clothes = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Are you sure ?"),
                content: Text("Do you really want to delete this item?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("No"),
                  ),
                  TextButton(
                      onPressed: () {
                        ClothesRepository().removeClothes(clothes.id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Yes"))
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              width: 280,
              child: FadeInImage(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                placeholder:
                    AssetImage("assets/images/clothes_placeholder.png"),
                image: NetworkImage(clothes.imageUrl),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Name:"),
                  Text(clothes.name),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Price:"),
                  Text(clothes.price.toString()),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Size:"),
                  Text(clothes.size),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              child: Text(clothes.description),
            )
          ],
        ),
      ),
    );
  }
}
