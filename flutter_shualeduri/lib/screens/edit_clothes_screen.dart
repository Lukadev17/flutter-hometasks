import 'package:flutter/material.dart';
import 'package:flutter_shualeduri/data/models/clothes_model.dart';
import 'package:flutter_shualeduri/data/repository/clothes_helper.dart';

class EditClothesScreen extends StatefulWidget {
  static const routeName = "/edit-clothes-screen";

  @override
  _EditClothesScreenState createState() => _EditClothesScreenState();
}

class _EditClothesScreenState extends State<EditClothesScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController clothesID;
  TextEditingController clothesName;
  TextEditingController clothesUrl;
  TextEditingController clothesSize;
  TextEditingController clothesPrice;
  TextEditingController clothesDescription;

  @override
  Widget build(BuildContext context) {
    final Map parsedData = ModalRoute.of(context).settings.arguments;
    final Clothes clothes = parsedData["clothes"];
    final int index = parsedData["index"];
    clothesID = TextEditingController(text: clothes.id.toString());
    clothesName = TextEditingController(text: clothes.name);
    clothesUrl = TextEditingController(text: clothes.imageUrl);
    clothesSize = TextEditingController(text: clothes.size);
    clothesPrice = TextEditingController(text: clothes.price.toString());
    clothesDescription = TextEditingController(text: clothes.description);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: TextFormField(
                    controller: clothesID,
                    decoration: InputDecoration(hintText: "Please enter Id"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Id";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: clothesName,
                    decoration: InputDecoration(hintText: "Please enter name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid name";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: clothesUrl,
                    decoration: InputDecoration(hintText: "Please enter URL"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid URL";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: clothesSize,
                    decoration: InputDecoration(hintText: "Please enter Size"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Size";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: clothesPrice,
                    decoration: InputDecoration(hintText: "Please enter Price"),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid Price";
                      }
                      return null;
                    },
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: clothesDescription,
                    decoration:
                    InputDecoration(hintText: "Please enter description"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid description";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Back"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Clothes clothes = Clothes(
                            id: int.parse(clothesID.text),
                            name: clothesName.text,
                            imageUrl: clothesUrl.text,
                            size: clothesSize.text,
                            price: double.parse(clothesPrice.text),
                            description: clothesDescription.text,
                          );
                          ClothesRepository().editClothes(clothes, index);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Edit"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
