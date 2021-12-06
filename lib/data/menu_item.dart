import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _menuCollection = _firestore.collection('Menu');

class MenuItem {
  final String id, name, description;
  final String image;

  final double price;
  final int xp;
  // final List<String> ingredients;
  final Map<String, dynamic> properties;

  MenuItem(this.id, this.name, this.description, this.image, this.price,
      this.xp, this.properties);

  Map<String, dynamic> mapTo() {
    var dataMap = new Map<String, dynamic>();
    dataMap['id'] = this.id;
    dataMap['name'] = this.name;
    dataMap['description'] = this.description;
    dataMap['imageUrl'] = this.image;
    dataMap['Price'] = this.price;
    dataMap['XP'] = this.xp;
    return dataMap;
  }

  factory MenuItem.fromMap(String id, Map<String, dynamic> map) {
    return MenuItem(id, map['Name'], map['Description'], map['ImageUrl'],
        map['Price'], map['XP'], map['Properties'] as Map<String, dynamic>);
  }
}
