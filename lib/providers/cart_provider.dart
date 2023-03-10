import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  addToCart({
    required String id,
    required List image,
    required String name,
    required int price,
    required int quantity,
    required String description,
  }) async {
    await FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartItems')
        .doc(id)
        .set({
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'description': description,
    });
  }

  // Show cart data
  List<CartModel> cartDataList = [];
  Future<void> showCart() async {
    List<CartModel> newList = [];
    QuerySnapshot collection = await FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartItems')
        .orderBy('name')
        .get();

    for (var element in collection.docs) {
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
    cartDataList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartData {
    return cartDataList;
  }

  // get tota price
  getTotalPrice() {
    int total = 0;
    for (var element in cartDataList) {
      total += element.price * element.quantity;
    }
    return total;
  }

  // delete cart
  deleteCart(id) {
    FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartItems')
        .doc(id)
        .delete();
    notifyListeners();
  }
}
