// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/cart_provider.dart';

class Count extends StatefulWidget {
  String id;
  String name;
  List image;
  int price;
  int quantity;
  String description;
  Count({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.description,
  }) : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  CartProvider? _cartProvider;

  bool isBool = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of(context);
    return SafeArea(
      child: SizedBox(
        child: isBool == true
            ? Icon(Icons.shopping_cart)
            : InkWell(
                onTap: () {
                  setState(() {
                    isBool = true;
                    if (isBool = true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text(
                            'Item added',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ),
                      );
                    }
                  });
                  _cartProvider!.addToCart(
                    id: widget.id,
                    image: widget.image,
                    name: widget.name,
                    price: widget.price,
                    quantity: widget.quantity,
                    description: widget.description,
                  );
                },
                child: Icon(Icons.shopping_cart_outlined),
              ),
      ),
    );
  }
}
