import 'package:erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerBillData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addCustomerBill(
    String customerName,
    String customerCity,
    String customerId,
    String paymentType,
    String userID,
    DateTime billAddTime,
  ) async {
    DocumentReference docRef = await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
        .add({
          "customer_name": customerName,
          "customer_city": customerCity,
          "customer_id": customerId,
          "total_product_price": 0,
          "total_profits": 0,
          "bill_date": billAddTime,
          "paymet_type": paymentType,
          "bill_no": "",
          "bill_status": BillStatus.itwasFormed,
          "discount_amount": 0,
        });
    return docRef.id;
  }

  void addDiscount(String billId, String userID, double discountAmount) {
    _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
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
        .collection("customer_bills")
        .doc(billId)
        .collection("products")
        .add({
          "product_name": productName,

          "product_id": productId,
          "product_number": productNumber,

          "total_product_price": totalProductPrice,
          "total_product_profits": totalProductProfits,

          "prodect_profits": prodectProfits,
          "product_price": productPrice,
        });
  }

  Future deleteCustomerBill(String userID, String billId) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
        .doc(billId)
        .delete();
  }

  Future updateCustomerBill(
    String userID,
    String billId,
    String billNo,
    double totalPrice,
    double totlProfits,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
        .doc(billId)
        .update({
          "total_product_price": totalPrice,
          "total_profits": totlProfits,
          "bill_no": billNo,
        });
  }
  Future updatePaymentType(
    String userID,
    String billId,
    String paymentType,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
        .doc(billId)
        .update({"paymet_type": paymentType});
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
        .collection("customer_bills")
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
        .collection("customer_bills")
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
        .collection("customer_bills")
        .doc(billId)
        .update({"bill_status": billStatus});
  }

  Future deleteProduct(
    String billId,
    String productId,
    String userID,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
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
        .collection("customer_bills")
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
        .collection("customer_bills")
        .doc(billId)
        .collection("products")
        .doc(prodcutId)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBils(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBillById(
    String userID,
    String billId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_bills")
        .doc(billId)
        .get();
  }
}
