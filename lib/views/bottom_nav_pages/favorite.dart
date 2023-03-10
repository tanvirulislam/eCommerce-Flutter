import 'package:flutter/material.dart';
import 'package:test_project/const.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
        actions: [
          Center(child: Text('Pull down to refresh')),
          SizedBox(width: 4),
        ],
      ),
      body: ListView(
        children: [
          for (var i = 0; i < 4; i++)
            Card(
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Burger', style: food_name_style),
                          Text('TK 120'),
                          Text('Quantity 2'),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline),
                        label: Text('Delete'),
                      ),
                      SizedBox(height: 4),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart_outlined),
                        label: Text('Cart'),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
