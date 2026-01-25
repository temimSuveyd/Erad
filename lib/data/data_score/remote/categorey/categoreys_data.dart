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

  void updateCategorey(
    String oldCategoreyName,
    String newCategoreyName,
    String userID,
  ) {
    // Delete old document
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys")
        .doc(oldCategoreyName)
        .delete();

    // Create new document with updated name
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys")
        .doc(newCategoreyName)
        .set({"categorey_name": newCategoreyName});
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

  void updateCategoreyType(
    String oldCategoreyType,
    String newCategoreyType,
    String categoreyName,
    String userID,
  ) {
    // Delete old document
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys_type")
        .doc(oldCategoreyType)
        .delete();

    // Create new document with updated name
    _firestore
        .collection("users")
        .doc(userID)
        .collection("categoreys_type")
        .doc(newCategoreyType)
        .set({
          "categorey_type": newCategoreyType,
          "categorey_name": categoreyName,
        });
  }

  void deleteCategorey_type(String userID, String categoreyType) {
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
