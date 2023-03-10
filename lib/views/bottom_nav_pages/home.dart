import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/category_provider.dart';
import 'package:test_project/providers/product_provider.dart';
import 'package:test_project/views/count.dart';
import 'package:test_project/views/product_overview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryProvider? categoryProvider;
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchSliderImage();
    productProvider.fatchMostlyOrdered();
    categoryProvider = Provider.of(context, listen: false);
    categoryProvider!.fatchCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Food App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 2.5,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                ),
                items: productProvider.getSliderImagedata.map<Widget>((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: i,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        // child: Image.network(i, fit: BoxFit.cover),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Text('Category', textScaleFactor: 1.5),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 160,
                            imageUrl:
                                categoryProvider.categoryList[index].image,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    categoryProvider.categoryList[index].name),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.shopping_cart_outlined),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text('Mostly Ordered', textScaleFactor: 1.5),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
              ),
              itemCount: productProvider.mostlyOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                child: ProductOverview(
                                  id: productProvider.mostlyOrderList[index].id,
                                  name: productProvider
                                      .mostlyOrderList[index].name,
                                  price: productProvider
                                      .mostlyOrderList[index].price,
                                  image: productProvider
                                      .mostlyOrderList[index].image,
                                  description: productProvider
                                      .mostlyOrderList[index].description,
                                ),
                                type: PageTransitionType.leftToRight),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                productProvider.mostlyOrderList[index].image[0],
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(productProvider.mostlyOrderList[index].name),
                            Text(
                              'TK ' +
                                  productProvider.mostlyOrderList[index].price
                                      .toString(),
                            ),
                            Count(
                              id: productProvider.mostlyOrderList[index].id,
                              name: productProvider.mostlyOrderList[index].name,
                              image:
                                  productProvider.mostlyOrderList[index].image,
                              price:
                                  productProvider.mostlyOrderList[index].price,
                              quantity: 1,
                              description: productProvider
                                  .mostlyOrderList[index].description,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
