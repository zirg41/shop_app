import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  static const String _authority = "shop-app-2cddb-default-rtdb.firebaseio.com";

  void toggleFavoriteStatus() async {
    var url = Uri.https(_authority, '/products/$id.json');
    await http.patch(
      url,
      body: json.encode(
        {
          "favorite": !isFavorite,
        },
      ),
    );
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
