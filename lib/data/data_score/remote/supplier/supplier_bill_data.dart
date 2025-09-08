import 'package:erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierBillData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addSupplierBill(
    String supplierName,
    String supplierCity,
    String supplierId,
    String paymentType,
    String userID,
    DateTime billAddTime,
  ) async {
    DocumentReference docRef = await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .add({
          "supplier_name": supplierName,
          "supplier_city": supplierCity,
          "supplier_id": supplierId,
          "total_product_price": 0,
          "total_profits": 0,
          "bill_date": billAddTime,
          "paymet_type": paymentType,
          "bill_no": "",
          "bill_status": BillStatus.itwasFormed,
          "discount_amount": 0,
          "bill_id": ""
        });
    return docRef.id;
  }


  void addDiscount(String billId, String userID, double discountAmount) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("suppliers_bills")
        .doc(billId)
        .update({
          "discount_amount": FieldValue.increment(discountAmount)
        });
  }
  void addProductToBill(
     String productName,
    int productPrice,
    String productId,
    int productNumber,
    int totalProductPrice,
    int totalProductProfits,
    int prodectProfits,
    String userID,
    String billId,
  ) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .collection("products")
        .add({
          "product_name": productName,
          "product_price": productPrice,
          "product_id": productId,
          "product_number": productNumber,
          "total_product_price": totalProductPrice,
          "prodect_profits": prodectProfits,
        });
  }

  Future deleteSupplierBill(String userID, String billId) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .delete();
  }

  Future updateSupplierBill(
    String userID,
    String billId,
    String billNo,
    double totalPrice,
    double totlProfits,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .update({
          "total_product_price": totalPrice,
          "total_profits": totlProfits,
          "bill_no": billNo,
        });
  }

  Future update_total_price(
    String userID,
    String billId,
    double totalPrice,
    double totlProfits,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .update({
          "total_product_price": totalPrice,
          "total_profits": totlProfits,
        });
  }

  Future updateProductData(
    String productId,
    int productNumber,
    int totalProductPrice,
    String userID,
    String billId,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .collection("products")
        .doc(productId)
        .update({
          "product_number": productNumber,
          "total_product_price": totalProductPrice,
        });
  }

  Future updateBillStatus(
    String userID,
    String billId,
    String billStatus,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .update({"bill_status": billStatus});
  }
  Future updatePaymentType(
    String userID,
    String billId,
    String paymentType,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .update({"paymet_type": paymentType});
  }
  Future deleteProduct(
    String billId,
    String productId,
    String userID,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .collection("products")
        .doc(productId)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBillProdects(
    String userID,
    String billId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .collection("products")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBillProdectBayId(
    String userID,
    String billId,
    String prodcutId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .collection("products")
        .doc(prodcutId)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBils(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBillById(
    String userID,
    String billId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_bills")
        .doc(billId)
        .get();
  }
}
