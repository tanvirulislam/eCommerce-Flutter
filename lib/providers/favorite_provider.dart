import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/models/cart_model.dart';

class FavoriteProvider extends ChangeNotifier {
  // add to favorite
  Future<void> addToFavorite({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required List image,
  }) async {
    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favoriteItems')
        .doc(id)
        .set({
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'itemAdded': true,
      'description': description,
    });
  }

  // show the favorites
  List<CartModel> favoriteList = [];
  Future<void> showFavorite() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favoriteItems')
        .orderBy('name')
        .get();
    List<CartModel> newList = [];
    for (var element in snapshot.docs) {
      CartModel model = CartModel(
        id: element.get('id'),
        image: element.get('image'),
        name: element.get('name'),
        price: element.get('price'),
        quantity: element.get('quantity'),
        description: element.get('description'),
      );
      newList.add(model);
    }
    favoriteList = newList;
    notifyListeners();
  }

  List<CartModel> get getFavoriteList {
    return favoriteList;
  }

  // delete favorite item
  deleteFavorite(id) {
    FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favoriteItems')
        .doc(id)
        .delete();
    notifyListeners();
  }
}
