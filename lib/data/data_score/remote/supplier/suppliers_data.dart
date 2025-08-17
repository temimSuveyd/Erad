import 'package:cloud_firestore/cloud_firestore.dart';

class SuppliersData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addSupplier(String user_email, String suppliers_name, String suppliers_city) {
    _firestore.collection("users").doc(user_email).collection("suppliers").add({
      "supplier_name": suppliers_name,
      "supplier_city": suppliers_city,
    });
  }

  deleteSupplier(String user_email, String suppliers_id) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("suppliers")
        .doc(suppliers_id)
        .delete();
  }

  editSupplier(
    String user_email,
    String supplier_name,
    String supplier_city,
    String suppliers_id,
  ) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("suppliers")
        .doc(suppliers_id)
        .update({
          "supplier_name": supplier_name,
          "supplier_city": supplier_city,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("suppliers")
        .snapshots();
  }


Stream<DocumentSnapshot<Map<String, dynamic>>> getSupplierByID(String user_email,String supplier_id) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("suppliers").doc(supplier_id)
        .snapshots();
  }
}
