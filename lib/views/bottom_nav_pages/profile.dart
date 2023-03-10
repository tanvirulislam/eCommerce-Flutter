import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/const.dart';
import 'package:test_project/google_signin/google_sign_in.dart';
import 'package:test_project/providers/user_provider.dart';
import 'package:test_project/views/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.getUserData();
  }

  final AuthClass _authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    var userData = userProvider.currentData;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            _authClass.logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false);
                          },
                          icon:
                              Icon(Icons.logout_outlined, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.cyan],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -45,
                  right: MediaQuery.of(context).size.width / 2 - 45,
                  child: Container(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        userData.first.userImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Name', style: food_name_style),
              subtitle: Text(userData.first.userName),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_outlined),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Email', style: food_name_style),
              subtitle: Text(userData.first.userEmail),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('My Order', style: food_name_style),
              trailing: Icon(Icons.arrow_forward),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined),
              title: Text('My Cart', style: food_name_style),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
