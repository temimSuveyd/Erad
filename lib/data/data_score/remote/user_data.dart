import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  add_user(String user_email) {
    _firebase.collection("users").doc(user_email).set({
      "user_email": user_email,
    });
  }
}
