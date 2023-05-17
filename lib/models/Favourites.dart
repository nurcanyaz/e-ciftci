import 'package:flutter/material.dart';
import 'product.dart';


class Favourites {
  final Product product;
  final int numOfItem;

  Favourites({required this.product, required this.numOfItem});
}

// Demo data for our cart

List<Favourites> demoCarts = [
  Favourites(product: demoProducts[0], numOfItem: 2),
  Favourites(product: demoProducts[1], numOfItem: 1),
  Favourites(product: demoProducts[3], numOfItem: 1),

];