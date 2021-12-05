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
  DocumentSnapshot accountQuery = await _mainCollection.doc(id).get();
  if (accountQuery.exists) {
    return Account.fromMap(id, accountQuery.data() as Map<String, dynamic>);
  } else {
    print('could not find document');
  }
}

Future<Account?> createAccount(String uid, String email) async {
  Account account = Account.NewAccount(uid, email);
  print(account.mapTo());
  await _mainCollection.doc(uid).set(account.mapTo());
  return account;
}
