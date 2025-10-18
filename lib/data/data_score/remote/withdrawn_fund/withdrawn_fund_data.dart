import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawnFundData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addWithdrawnFund(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String userId,
    String id,
  ) async {
    final doc = await _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .doc(id)
        .collection("withdrawn_fund")
        .add({
          "date": date,
          "amount": totalAmount,
          "is_repeat_withdrawn_fund": isRepeatExpense,
          "repeat_date": repeatDate,
          "userId": userId,
        });
    return doc.id;
  }

  Future editWithdrawnFund(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String id,
    String categoryID,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .doc(categoryID)
        .collection("withdrawn_fund")
        .doc(id)
        .update({
          "date": date,
          "amount": totalAmount,
          "is_repeat_withdrawn_fund": isRepeatExpense,
          "repeat_date": repeatDate,
        });
  }

  Future deleteWithdrawnFund(
    String userID,
    String id,
    String categoryID,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .doc(categoryID)
        .collection("withdrawn_fund")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getWithdrawnFund(
    String userID,
    String categoryID,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .doc(categoryID)
        .collection("withdrawn_fund")
        .orderBy("date", descending: false)
        .snapshots();
  }

  // expenses category
  Future addWithdrawnFundCategory(String userID, String userId) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .add({"userId": userId});
  }

  Future editWithdrawnFundCategory(
    String userID,
    String userId,
    String id,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .doc(id)
        .update({"userId": userId});
  }

  Future deleteWithdrawnFundCategory(String userID, String id) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getWithdrawnFundCategory(
    String userID,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("withdrawn_fund_category")
        .snapshots();
  }
}
