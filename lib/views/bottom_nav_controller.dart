import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:test_project/views/bottom_nav_pages/cart.dart';
import 'package:test_project/views/bottom_nav_pages/favorite.dart';
import 'package:test_project/views/bottom_nav_pages/home.dart';
import 'package:test_project/views/bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _selectiveIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectiveIndex],
        bottomNavigationBar: GNav(
          selectedIndex: _selectiveIndex,
          onTabChange: (value) {
            setState(() {
              _selectiveIndex = value;
            });
          },
          rippleColor: Colors.cyan,
          curve: Curves.linear,
          duration: Duration(milliseconds: 500),
          gap: 8,
          color: Colors.grey.shade700,
          activeColor: Colors.cyan,
          iconSize: 24,
          tabBackgroundColor: Colors.grey.withOpacity(0.2),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.shoppingCart,
              text: 'Cart',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Favorite',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
