import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem<String>>? convertToDropdownItems(List<QueryDocumentSnapshot<Map<String, dynamic>>> documents , String type) {
  return documents.map((doc) => DropdownMenuItem<String>(
    value: doc.id,
    child: Text(doc.data()[type] ?? '', style: TextStyle(fontSize: 18)),
  )).toList();
}
