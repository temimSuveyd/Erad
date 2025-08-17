import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addCustomer(String user_email, String customer_name, String customer_city) {
    _firestore.collection("users").doc(user_email).collection("customers").add({
      "customer_name": customer_name,
      "customer_city": customer_city,
    });
  }

  deleteCustomer(String user_email, String customer_id) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("customers")
        .doc(customer_id)
        .delete();
  }

  editCustomer(
    String user_email,
    String customer_name,
    String customer_city,
    String customer_id,
  ) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("customers")
        .doc(customer_id)
        .update({
          "customer_name": customer_name,
          "customer_city": customer_city,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customers")
        .snapshots();
  }


Stream<DocumentSnapshot<Map<String, dynamic>>> getCustomerByID(String user_email,String customer_id) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customers").doc(customer_id)
        .snapshots();
  }
}
