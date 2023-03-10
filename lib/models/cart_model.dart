// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  String id;
  List image;
  String name;
  int price;
  int quantity;
  String description;
  CartModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
  });
}
