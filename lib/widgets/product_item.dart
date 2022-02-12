import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(imageUrl),
    );
  }
}
