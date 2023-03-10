import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/models/user_model.dart';

class UserProvider with ChangeNotifier {
  // add data into firebase
  void addUser({
    required User currentUser,
    required String email,
    required String name,
    required String image,
  }) async {
    await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(currentUser.uid)
        .set({
      'userId': currentUser.uid,
      'name': name,
      'email': email,
      'image': image,
    });
  }

  // get data from firebase
  List<UserModel> currentData = [];
  Future getUserData() async {
    List<UserModel> newList = [];
    var value = await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (value.exists) {
      print(value.data());
      UserModel userModel = UserModel(
        userUid: value.get('userId'),
        userName: value.get('name'),
        userEmail: value.get('email'),
        userImage: value.get('image'),
      );
      newList.add(userModel);
    }
    currentData = newList;
    notifyListeners();
  }

  List<UserModel> get currentUserData {
    return currentData;
  }
}
