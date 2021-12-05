import 'package:flutter/material.dart';

class MenuItem {
  final String id, name, description;
  final String image;

  final double price;
  final int xp;
  final List<String> ingredients;

  MenuItem(this.id, this.name, this.description, this.image, this.price,
      this.xp, this.ingredients);

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(map['id'], map['name'], map['description'], map['image'],
        map['price'], map['xp'], map['ingredients']);
  }
}
