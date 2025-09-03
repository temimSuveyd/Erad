import 'package:cloud_firestore/cloud_firestore.dart';

class SuppliersData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addSupplier(String userID, String suppliers_name, String suppliers_city) {
    _firestore.collection("users").doc(userID).collection("suppliers").add({
      "supplier_name": suppliers_name,
      "supplier_city": suppliers_city,
    });
  }

  deleteSupplier(String userID, String suppliers_id) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers")
        .doc(suppliers_id)
        .delete();
  }

  editSupplier(
    String userID,
    String supplier_name,
    String supplier_city,
    String suppliers_id,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers")
        .doc(suppliers_id)
        .update({
          "supplier_name": supplier_name,
          "supplier_city": supplier_city,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers")
        .snapshots();
  }


Stream<DocumentSnapshot<Map<String, dynamic>>> getSupplierByID(String userID,String supplier_id) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers").doc(supplier_id)
        .snapshots();
  }
}
