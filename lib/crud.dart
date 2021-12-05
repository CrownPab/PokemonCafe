import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:pokemon_cafe/account.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Users');
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
