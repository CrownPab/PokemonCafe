import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:pokemon_cafe/account.dart';
import 'package:pokemon_cafe/data/menu_item.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Users');
final CollectionReference _menuCollection = _firestore.collection('Menu');
Future initializeFirebase() async {
  await Firebase.initializeApp();
}

Future<Account?> getAccount(String id) async {
  print(id);
  DocumentSnapshot accountQuery = await _mainCollection.doc(id).get();
  if (accountQuery.exists) {
    return Account.fromMap(id, accountQuery.data() as Map<String, dynamic>);
  } else {
    print('could not find document');
  }
}

Future<bool> createAccount(Account account) async {
  print(account.mapTo());
  await _mainCollection.doc(account.id).set(account.mapTo());
  return true;
}

Future<List<MenuItem>> getAllMenuItems() async {
  QuerySnapshot snapshot = await _menuCollection.get();
  return snapshot.docs
      .map((e) => MenuItem.fromMap(e.id, e.data() as Map<String, dynamic>))
      .toList();
}
