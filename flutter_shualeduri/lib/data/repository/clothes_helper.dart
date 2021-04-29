import 'package:flutter_shualeduri/data/models/clothes_model.dart';
import 'package:flutter_shualeduri/data/models/dummy_data.dart';

class ClothesRepository{
  void addClothes(Clothes clothes){
    DUMMY_DATA.add(clothes);
  }
  void removeClothes(int id){
    DUMMY_DATA.removeWhere((element) => element.id == id);
  }

  void editClothes(Clothes clothes, int index){
    DUMMY_DATA.replaceRange(index, index + 1, [clothes]);
  }
}