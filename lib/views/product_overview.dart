// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/favorite_provider.dart';

import 'package:test_project/views/bottom_nav_pages/favorite.dart';

// ignore: must_be_immutable
class ProductOverview extends StatefulWidget {
  String id;
  String name;
  int price;
  List image;
  String description;

  ProductOverview({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  FavoriteProvider? _favoriteProvider;
  int count = 1;
  bool addedToFavorite = false;
  @override
  void initState() {
    getFavoriteItem();
    super.initState();
  }

  getFavoriteItem() async {
    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favoriteItems')
        .doc(widget.id)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  if (mounted)
                    {
                      setState(() {
                        addedToFavorite = value.get("itemAdded");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    _favoriteProvider = Provider.of(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: FavoriteScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              icon: Icon(Icons.favorite_outline),
            ),
          ],
        ),
        body: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width < 400 ? 300 : 200,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              items: widget.image.map<Widget>((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: i,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // child: Image.network(i, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Discription', textScaleFactor: 1.5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.name, textScaleFactor: 1.5),
                  Text('TK ' + widget.price.toString()),
                  ElevatedButton.icon(
                    onPressed: () {
                      _favoriteProvider!.addToFavorite(
                        id: widget.id,
                        name: widget.name,
                        price: widget.price,
                        quantity: count,
                        image: widget.image,
                        description: widget.description,
                      );
                      if (addedToFavorite == false) {
                        setState(() {
                          addedToFavorite = true;
                        });
                      }
                    },
                    icon: addedToFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_outline),
                    label: addedToFavorite
                        ? Text('Item added')
                        : Text('Add to favorite'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quantity  1'),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: Text('Add to Cart'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
