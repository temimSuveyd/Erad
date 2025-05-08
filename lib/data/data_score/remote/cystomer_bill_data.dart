import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerBillData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addCustomerBill(
    String customer_name,
    String customer_city,
    String customer_id,
    String payment_type,
    String user_email,
    DateTime bill_add_time,
  ) async {
    DocumentReference docRef = await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_bills")
        .add({
          "customer_name": customer_name,
          "customer_city": customer_city,
          "customer_id": customer_id,
          "total_price": "",
          "bill_date": bill_add_time,
          "paymet_type": payment_type,
        });
    return docRef.id;
  }

  addProductToBill(
    String product_name,
    int product_price,
    String product_id,
    int product_number,
    int total_product_price,
    String user_email,
    String bill_id,
  ) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_bills")
        .doc(bill_id)
        .collection("products")
        .add({
          "product_name": product_name,
          "product_price": product_price,
          "product_id": product_id,
          "product_number": product_number,
          "Total product price": total_product_price,
        });
  }

  deleteCustomerBill(String user_email, String bill_id) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_bills")
        .doc(bill_id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBillProdects(
    String user_email,
    String bill_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_bills")
        .doc(bill_id)
        .collection("products")
        .snapshots();
  }
}
