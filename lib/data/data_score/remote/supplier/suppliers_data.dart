import 'package:cloud_firestore/cloud_firestore.dart';

class SuppliersData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addSupplier(String userID, String suppliersName, String suppliersCity) {
    _firestore.collection("users").doc(userID).collection("suppliers").add({
      "supplier_name": suppliersName,
      "supplier_city": suppliersCity,
    });
  }

  void deleteSupplier(String userID, String suppliersId) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers")
        .doc(suppliersId)
        .delete();
  }

  void editSupplier(
    String userID,
    String supplierName,
    String supplierCity,
    String suppliersId,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers")
        .doc(suppliersId)
        .update({
          "supplier_name": supplierName,
          "supplier_city": supplierCity,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers")
        .snapshots();
  }


Stream<DocumentSnapshot<Map<String, dynamic>>> getSupplierByID(String userID,String supplierId) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers").doc(supplierId)
        .snapshots();
  }
}
