import 'package:flutter/material.dart';

class Product {
  final int id;
  final String seller;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.seller,
  });
}

// Our demo Products


List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/Limon Photo.jpg",
      "assets/images/Portakal Photo.jpg",
      "assets/images/Badem Photo.jpg",
      "assets/images/Zeytin Photo.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Toplu fideler-4 alana 1 bedava™",
    price: 64.99,
    description: description1,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
    seller: "Nurcan Yaz",

  ),
  Product(
    id: 2,
    images: [
      "assets/images/Popular Product 2.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Sezonun Son Erikleri",
    price: 50.5,
    description: description2,
    rating: 4.1,
    isPopular: true,
    seller: "Ayşe Avcı",
  ),
  Product(
    id: 3,
    images: [
      "assets/images/Popular Product 3.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Kayısı zamanı",
    price: 36.55,
    description: description3,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
    seller: "Nihal Yılmaz",
  ),
  Product(
      id: 4,
      images: [
        "assets/images/Domates Photo.jpg",
      ],
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      title: "Taze Domates",
      price: 20.20,
      description: description4,
      rating: 4.1,
      isFavourite: true,
      seller:"Hagar Hamad"
  ),
];

const String description1 =
    "Ayın son indirimiyle sizlerleyiz. Toplu fide satışımız başlamıştır. Limon, Zeytin, Portakal ve Badem fideleri sizinle. Hemen satın al ve fidanını dikmeye başla  …";
const String description2=
    "Mersin eriğinin en gözdeleri sizinle...";
const String description3=
    "Mayıs ayında bulabileceğiniz en lezzetli kayısılar satışta...";
const String description4=
    "En tazer domates buradan alınır...";