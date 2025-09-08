import 'package:cloud_firestore/cloud_firestore.dart';

class CategoreysData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // categorey

  void addCategoreys(String categoreyName, String userID) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys")
        .doc(categoreyName)
        .set({"categorey_name": categoreyName});
  }

    void deleteCategorey(String categoreyName, String userID) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys")
        .doc(categoreyName)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoreys(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys")
        .snapshots();
  }


  void addCategorey_type(
    String categoreyName,
    String userID,
    String categoreyType,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys_type")
        .doc(categoreyType)
        .set({
          "categorey_type": categoreyType,
          "categorey_name": categoreyName,
        });
  }
  void deleteCategorey_type(
    String userID,
    String categoreyType,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys_type")
        .doc(categoreyType)
        .delete();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoreysType(
    String userID,
    String categoreyName,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys_type")
        .where("categorey_name", isEqualTo: categoreyName)
        .snapshots();
  }
}
