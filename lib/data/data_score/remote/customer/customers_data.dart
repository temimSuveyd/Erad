import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addCustomer(String userID, String customerName, String customerCity) {
    _firestore.collection("users").doc(userID).collection("customers").add({
      "customer_name": customerName,
      "customer_city": customerCity,
    });
  }

  void deleteCustomer(String userID, String customerId) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("customers")
        .doc(customerId)
        .delete();
  }

  void editCustomer(
    String userID,
    String customerName,
    String customerCity,
    String customerId,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("customers")
        .doc(customerId)
        .update({
          "customer_name": customerName,
          "customer_city": customerCity,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customers")
        .snapshots();
  }


Stream<DocumentSnapshot<Map<String, dynamic>>> getCustomerByID(String userID,String customerId) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customers").doc(customerId)
        .snapshots();
  }
}
