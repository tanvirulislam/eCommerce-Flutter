import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/const.dart';
import 'package:test_project/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider? _cartProvider;
  @override
  void initState() {
    _cartProvider = Provider.of(context, listen: false);
    _cartProvider!.showCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
        actions: [
          Center(child: Text('Pull down to refresh')),
          SizedBox(width: 4),
        ],
      ),
      body: ListView(
        children: _cartProvider!.getCartData
            .map(
              (e) => Column(
                children: [
                  Card(
                    elevation: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                          imageUrl: e.image[0],
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.name, style: food_name_style),
                                  Text('TK ' + e.price.toString()),
                                  Text('Quantity ' + e.quantity.toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _cartProvider!.deleteCart(e.id);
                                setState(() {
                                  _cartProvider!.showCart();
                                });
                              },
                              icon: Icon(Icons.delete_outline),
                              label: Text('Delete'),
                            ),
                            SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(100, 40),
                                padding: EdgeInsets.all(0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Center(
                                      child: Text('1', style: food_name_style)),
                                  Icon(Icons.remove),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount: TK ' +
                    _cartProvider!.getTotalPrice().toString()),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
