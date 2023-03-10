import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/const.dart';
import 'package:test_project/providers/cart_provider.dart';
import 'package:test_project/providers/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of(context);
    favoriteProvider.showFavorite();
    CartProvider cartProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
        actions: [
          Center(child: Text('Pull down to refresh')),
          SizedBox(width: 4),
        ],
      ),
      body: ListView(
        children: favoriteProvider.getFavoriteList
            .map((e) => Card(
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl: e.image[0],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                              Text(e.name, style: food_name_style),
                              Text('TK ' + e.price.toString()),
                              Text('Quantity ' + e.quantity.toString()),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              favoriteProvider.deleteFavorite(e.id);
                            },
                            icon: Icon(Icons.delete_outline),
                            label: Text('Delete'),
                          ),
                          SizedBox(height: 4),
                          ElevatedButton.icon(
                            onPressed: () {
                              cartProvider.addToCart(
                                id: e.id,
                                image: e.image,
                                name: e.name,
                                price: e.price,
                                quantity: e.quantity,
                                description: e.description,
                              );
                              favoriteProvider.deleteFavorite(e.id);
                            },
                            icon: Icon(Icons.shopping_cart_outlined),
                            label: Text('Cart'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
