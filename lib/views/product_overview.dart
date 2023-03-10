// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:test_project/const.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () {},
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
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                  label: Text('Add to Favorite'),
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
    );
  }
}
