import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addExpenses(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String title,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses")
        .add({
          "date": date,
          "amount": totalAmount,
          "is_repeat_expense": isRepeatExpense,
          "repeat_date": repeatDate,
          "title": title,
        });
  }

  Future editExpenses(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String title,
    String id,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses")
        .doc(id)
        .update({
          "date": date,
          "amount": totalAmount,
          "is_repeat_expense": isRepeatExpense,
          "repeat_date": repeatDate,
          "title": title,
        });
  }

  Future deleteExpenses(
    String userID,
    String id,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getExpenses(String userID) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses")
        .snapshots();
  }
}
