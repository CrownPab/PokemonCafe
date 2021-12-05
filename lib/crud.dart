import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

Stream<QuerySnapshot> readItems() { 
  CollectionReference notesItemCollection = _mainCollection.doc('E09hPBjLbidu4gHF4KxH').collection('Users');

  return notesItemCollection.snapshots();

}
