import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getExcersices() async {
  List excersices = [];
  CollectionReference collectionReference = db.collection('excersices');
  QuerySnapshot queryExcersices = await collectionReference
      .get(); // hace la query para toda la db, ineficiente si hay muchos datos

  queryExcersices.docs.forEach((document) {
    excersices.add(document.data());
  });

  return excersices;
}

Future<void> addExcersice(
    List<String> texList, int studentQuantity, int excersicesPerStudent, String topic) async {
  String? user = FirebaseAuth.instance.currentUser?.uid;

  if (user == null) {
    return;
  } else {
    await db.collection('excersices').add({
      'excersice': texList,
      'studentQuantity': studentQuantity,
      'excersicesPerStudent': excersicesPerStudent,
      'userId': user,
      'topic': topic
    });
  }
}

String getUId() {
  return '${FirebaseAuth.instance.currentUser?.uid}';
}
