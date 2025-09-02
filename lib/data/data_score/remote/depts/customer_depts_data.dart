import 'package:erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDeptsData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addDepts(
    String customer_id,
    String customer_name,
    String customer_city,

    String user_email,
    double total_price,
    DateTime bill_add_time,
  ) async {
    final docRef = _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      return await docRef.set({
        "dept_id": docSnapshot.id,
        "total_price": total_price,
        "bill_date": bill_add_time,
        "customer_name": customer_name,
        "customer_city": customer_city,
        "customer_id": customer_id,
      });
    }
  }

  Future addBillToDepts(
    String bill_no,
    String bill_id,
    String customer_id,
    String payment_type,
    String user_email,
    double total_price,
    DateTime bill_add_time,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("customer_bills")
        .doc(bill_id)
        .set({
          "bill_id": bill_id,
          "customer_id": customer_id,
          "total_price": total_price,
          "bill_date": bill_add_time,
          "paymet_type": payment_type,
          "bill_no": bill_no,
          "bill_status": BillStatus.itwasFormed,
        });
  }

  Future addPaymentToDepts(
    String customer_id,
    String user_email,
    double total_price,
    DateTime payment_date,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("payments")
        .add({"payment_date": payment_date, "total_price": total_price});
  }

  Future delteBillFromDepts(
    String bill_id,
    String customer_id,
    String user_email,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("customer_bills")
        .doc(bill_id)
        .delete();
  }
  Future deltePaymentFromDepts(
    String payment_id,
    String customer_id,
    String user_email,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("payments")
        .doc(payment_id)
        .delete();
  }
  Future updateTotalPriceInBill(
    String bill_id,
    String customer_id,
    String user_email,
    double total_price,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("customer_bills")
        .doc(bill_id)
        .update({"total_price": total_price});
  }

  Future updateTotalDept(
    String customer_id,
    String user_email,
    double total_price,
  ) async {
    return await _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .update({"total_price": total_price});
  }

  Future delteDepts(String customer_id, String user_email) async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id);

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllDepts(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPayments(
    String user_email,
    String customer_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("payments")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBillById(
    String user_email,
    String customer_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .collection("customer_bills")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDeptDetails(
    String user_email,
    String customer_id,
  ) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_depts")
        .doc(customer_id)
        .get();
  }
}
