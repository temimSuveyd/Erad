import 'package:Erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierBillData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addSupplierBill(
    String supplier_name,
    String supplier_city,
    String supplier_id,
    String payment_type,
    String user_email,
    DateTime bill_add_time,
  ) async {
    DocumentReference docRef = await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .add({
          "supplier_name": supplier_name,
          "supplier_city": supplier_city,
          "supplier_id": supplier_id,
          "total_product_price": 0,
          "total_profits": 0,
          "bill_date": bill_add_time,
          "paymet_type": payment_type,
          "bill_no": "",
          "bill_status": BillStatus.itwasFormed,
        });
    return docRef.id;
  }

  addProductToBill(
    String product_name,
    int product_price,
    String product_id,
    int product_number,
    int total_product_price,
    int prodect_profits,
    String user_email,
    String bill_id,
  ) {
    _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .collection("products")
        .add({
          "product_name": product_name,
          "product_price": product_price,
          "product_id": product_id,
          "product_number": product_number,
          "total_product_price": total_product_price,
          "prodect_profits": prodect_profits,
        });
  }

  Future deleteSupplierBill(String user_email, String bill_id) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .delete();
  }

  Future updatesupplierBill(
    String user_email,
    String bill_id,
    String bill_no,
    int total_price,
    int totl_profits,
  ) async {
    await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .update({
          "total_product_price": total_price,
          "total_profits": totl_profits,
          "bill_no": bill_no,
        });
  }

  Future update_total_price(
    String user_email,
    String bill_id,
    int total_price,
    int totl_profits,
  ) async {
    await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .update({
          "total_product_price": total_price,
          "total_profits": totl_profits,
        });
  }

  Future updateProductData(
    String product_id,
    int product_number,
    int total_product_price,
    String user_email,
    String bill_id,
  ) async {
    await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .collection("products")
        .doc(product_id)
        .update({
          "product_number": product_number,
          "total_product_price": total_product_price,
        });
  }

  Future updateBillStatus(
    String user_email,
    String bill_id,
    String bill_status,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .update({"bill_status": bill_status});
  }

  Future deleteProduct(
    String bill_id,
    String product_id,
    String user_email,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .collection("products")
        .doc(product_id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBillProdects(
    String user_email,
    String bill_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .collection("products")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBillProdectBayId(
    String user_email,
    String bill_id,
    String prodcut_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .collection("products")
        .doc(prodcut_id)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBils(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBillById(
    String user_email,
    String bill_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("supplier_bills")
        .doc(bill_id)
        .get();
  }
}
