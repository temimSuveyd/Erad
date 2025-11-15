import 'package:erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierDeptsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addDepts(
    String supplierId,
    String supplierName,
    String supplierCity,

    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    final docRef = _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return await docRef.set({
        "dept_id": docSnapshot.id,
        "total_price": totalPrice,
        "bill_date": billAddTime,
        "supplier_name": supplierName,
        "supplier_city": supplierCity,
        "supplier_id": supplierId,
      });
    }
  }

  Future addBillToDepts(
    String billNo,
    String billId,
    String supplierId,
    String paymentType,
    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("supplier_bills")
        .doc(billId)
        .set({
          "bill_id": billId,
          "supplier_id": supplierId,
          "total_price": totalPrice,
          "bill_date": billAddTime,
          "paymet_type": paymentType,
          "bill_no": billNo,
          "bill_status": BillStatus.itwasFormed,
        });
  }

  Future addPaymentToDepts(
    String supplierId,
    String userID,
    double totalPrice,
    DateTime paymentDate,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("payments")
        .add({"payment_date": paymentDate, "total_price": totalPrice});
  }

  Future delteBillFromDepts(
    String billId,
    String supplierId,
    String userID,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("supplier_bills")
        .doc(billId)
        .delete();
  }

  Future deltePaymentFromDepts(
    String paymentId,
    String supplierId,
    String userID,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("payments")
        .doc(paymentId)
        .delete();
  }

  Future updateTotalPriceInBill(
    String billId,
    String supplierId,
    String userID,
    double totalPrice,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("supplier_bills")
        .doc(billId)
        .update({"total_price": totalPrice});
  }

  Future updateTotalDept(
    String supplierId,
    String userID,
    double totalPrice,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .update({"total_price": totalPrice});
  }

  Future delteDepts(String supplierId, String userID) async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId);

    final billsCollections = await docRef.collection("supplier_bills").get();
    final paymentsCollections = await docRef.collection("payments").get();

    for (final subDoc in billsCollections.docs) {
      await subDoc.reference.delete();
    }
    for (final subDoc in paymentsCollections.docs) {
      await subDoc.reference.delete();
    }
    await docRef.delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllDepts(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .orderBy("bill_date", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPayments(
    String userID,
    String supplierId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("payments")
        .orderBy("payment_date", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBillById(
    String userID,
    String supplierId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .collection("supplier_bills")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDeptDetails(
    String userID,
    String supplierId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("supplier_depts")
        .doc(supplierId)
        .get();
  }
}
