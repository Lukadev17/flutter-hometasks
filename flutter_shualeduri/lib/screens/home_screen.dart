import 'package:flutter/material.dart';
import 'package:flutter_shualeduri/data/models/clothes_model.dart';
import 'package:flutter_shualeduri/data/models/dummy_data.dart';
import 'package:flutter_shualeduri/screens/add_new_clothes_screen.dart';
import 'package:flutter_shualeduri/screens/edit_clothes_screen.dart';
import 'package:flutter_shualeduri/widgets/main_list_item.dart';

import 'clothes_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Clothes> clothesList = DUMMY_DATA;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clothes App"),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 240, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          var clothes = clothesList[index];
          return Container(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                      context, ClothesDetailsScreen.routeName,
                      arguments: clothes)
                  .then((_) {
                setState(() {});
              }),
              onLongPress: () {
                Navigator.pushNamed(
                  context,
                  EditClothesScreen.routeName,
                  arguments: {"clothes": clothes, "index": index},
                ).then((_) {
                  setState(() {});
                });
              },
              child: MainListItem(
                imageUrl: clothes.imageUrl,
                name: clothes.name,
                price: clothes.price.toString(),
              ),
            ),
          );
        },
        itemCount: clothesList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AddNewClothesScreen.routeName)
                .then((_) {
          setState(() {});
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
