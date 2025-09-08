import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  void add_user(String userID) {
    _firebase.collection("users").doc(userID).set({
      "userID": userID,
    });
  }
}
