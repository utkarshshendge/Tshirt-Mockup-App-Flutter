import 'package:flutter/material.dart';

class Product {
  final String productName;
  final String image;
  final String price;
  final String description;

  Product({
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.productName
  });
}