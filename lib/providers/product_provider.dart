import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_project/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  // show slider
  List sliderImage = [];
  fatchSliderImage() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('carousel-slider').get();
    for (var i = 0; i < snapshot.docs.length; i++) {
      sliderImage.add(snapshot.docs[i]['img-path']);
    }
    notifyListeners();
  }

  get getSliderImagedata {
    return sliderImage;
  }

  // show mostly ordered food
  List<ProductModel> mostlyOrderList = [];
  Future<void> fatchMostlyOrdered() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('mostly-ordered')
        .orderBy('name')
        .get();
    for (var element in snapshot.docs) {
      ProductModel model = ProductModel(
        id: element.get('id'),
        name: element.get('name'),
        image: element.get('image'),
        description: element.get('description'),
        price: element.get('price'),
      );
      newList.add(model);
    }
    mostlyOrderList = newList;
    notifyListeners();
  }
}
