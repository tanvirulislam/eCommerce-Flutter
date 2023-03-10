import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/user_provider.dart';
import 'package:test_project/views/bottom_nav_controller.dart';

class AuthClass {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();
  Future<void> handleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication authentication =
            await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: authentication.idToken,
            accessToken: authentication.accessToken);

        User? user = (await auth.signInWithCredential(authCredential)).user;
        print("signed in----------- " + user!.email.toString());

        UserProvider provider = Provider.of(context, listen: false);
        provider.addUser(
          currentUser: user,
          email: user.email.toString(),
          name: user.displayName.toString(),
          image: user.photoURL.toString(),
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        storeToken(userCredential);
        print('-----------------Store token' +
            storeToken(userCredential).toString());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavController(),
            ),
            (route) => false);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> storeToken(UserCredential userCredential) async {
    await storage.write(
      key: 'token',
      value: userCredential.credential!.token.toString(),
    );
    await storage.write(
      key: 'userCredential',
      value: userCredential.toString(),
    );
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  logout() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: 'token');
    } catch (e) {
      print(e.toString());
    }
  }
}
