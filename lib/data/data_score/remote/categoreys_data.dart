import 'package:cloud_firestore/cloud_firestore.dart';

class CategoreysData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // categorey

  addCategoreys(String categorey_name, String user_email) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("categoreys")
        .doc(categorey_name)
        .set({"categorey_name": categorey_name});
  }

    deleteCategorey(String categorey_name, String user_email) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("categoreys")
        .doc(categorey_name)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoreys(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("categoreys")
        .snapshots();
  }


  addCategorey_type(
    String categorey_name,
    String user_email,
    String categorey_type,
  ) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("categoreys_type")
        .doc(categorey_type)
        .set({
          "categorey_type": categorey_type,
          "categorey_name": categorey_name,
        });
  }
  deleteCategorey_type(
    String user_email,
    String categorey_type,
  ) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("categoreys_type")
        .doc(categorey_type)
        .delete();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoreysType(
    String user_email,
    String categorey_name,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("categoreys_type")
        .where("categorey_name", isEqualTo: categorey_name)
        .snapshots();
  }
}
