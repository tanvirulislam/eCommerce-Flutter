import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_project/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  Future<void> fatchCategory() async {
    List<CategoryModel> newList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    for (var element in querySnapshot.docs) {
      CategoryModel categoryModel = CategoryModel(
        id: element.get('id'),
        name: element.get('name'),
        image: element.get('image'),
      );
      newList.add(categoryModel);
    }
    categoryList = newList;
    notifyListeners();
  }

  // List<CategoryModel> get getCategoryData {
  //   return categoryList;
  // }
}
