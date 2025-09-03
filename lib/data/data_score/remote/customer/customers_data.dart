import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addCustomer(String userID, String customer_name, String customer_city) {
    _firestore.collection("users").doc(userID).collection("customers").add({
      "customer_name": customer_name,
      "customer_city": customer_city,
    });
  }

  deleteCustomer(String userID, String customer_id) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("customers")
        .doc(customer_id)
        .delete();
  }

  editCustomer(
    String userID,
    String customer_name,
    String customer_city,
    String customer_id,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("customers")
        .doc(customer_id)
        .update({
          "customer_name": customer_name,
          "customer_city": customer_city,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customers")
        .snapshots();
  }


Stream<DocumentSnapshot<Map<String, dynamic>>> getCustomerByID(String userID,String customer_id) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customers").doc(customer_id)
        .snapshots();
  }
}
