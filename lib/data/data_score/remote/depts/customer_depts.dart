import 'package:Erad/core/constans/bill_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDeptsData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllDepts(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customer_bills")
        .where("bill_status", isEqualTo: "deliveryd")
        .where("paymet_type", isEqualTo: "Religion")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCustomers(String user_email) {
    return _firestore
        .collection("users")
        .doc(user_email)
        .collection("customers")
        .snapshots();
  }
}
