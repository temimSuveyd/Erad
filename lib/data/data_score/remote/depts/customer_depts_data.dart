import 'package:erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDeptsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addDepts(
    String customerId,
    String customerName,
    String customerCity,

    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    final docRef = _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return await docRef.set({
        "dept_id": docSnapshot.id,
        "total_price": totalPrice,
        "bill_date": billAddTime,
        "customer_name": customerName,
        "customer_city": customerCity,
        "customer_id": customerId,
      });
    }
  }

  Future addBillToDepts(
    String billNo,
    String billId,
    String customerId,
    String paymentType,
    String userID,
    double totalPrice,
    DateTime billAddTime,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("customer_bills")
        .doc(billId)
        .set({
          "bill_id": billId,
          "customer_id": customerId,
          "total_price": totalPrice,
          "bill_date": billAddTime,
          "paymet_type": paymentType,
          "bill_no": billNo,
          "bill_status": BillStatus.itwasFormed,
        });
  }

  Future addPaymentToDepts(
    String customerId,
    String userID,
    double totalPrice,
    DateTime paymentDate,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("payments")
        .add({"payment_date": paymentDate, "total_price": totalPrice});
  }

  Future delteBillFromDepts(
    String billId,
    String customerId,
    String userID,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("customer_bills")
        .doc(billId)
        .delete();
  }
  Future deltePaymentFromDepts(
    String paymentId,
    String customerId,
    String userID,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("payments")
        .doc(paymentId)
        .delete();
  }
  Future updateTotalPriceInBill(
    String billId,
    String customerId,
    String userID,
    double totalPrice,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("customer_bills")
        .doc(billId)
        .update({"total_price": totalPrice});
  }

  Future updateTotalDept(
    String customerId,
    String userID,
    double totalPrice,
  ) async {
    return await _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .update({"total_price": totalPrice});
  }

  Future delteDepts(String customerId, String userID) async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId);

    final billsCollections = await docRef.collection("customer_bills").get();
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
        .collection("customer_depts")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPayments(
    String userID,
    String customerId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("payments")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBillById(
    String userID,
    String customerId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .collection("customer_bills")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDeptDetails(
    String userID,
    String customerId,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("customer_depts")
        .doc(customerId)
        .get();
  }
}
