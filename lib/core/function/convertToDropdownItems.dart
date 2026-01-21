import 'package:flutter/material.dart';

List<DropdownMenuItem<String>>? convertToDropdownItems(
  List<Map<String, dynamic>> documents,
  String type,
) {
  return documents
      .map(
        (doc) => DropdownMenuItem<String>(
          value: doc['id'].toString(),
          child: Text(doc[type] ?? '', style: TextStyle(fontSize: 18)),
        ),
      )
      .toList();
}
