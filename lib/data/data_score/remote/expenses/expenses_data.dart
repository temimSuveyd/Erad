import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addExpenses(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String title,
    String id,
  ) async {
    final doc =
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .doc(id)
        .collection("expenses")
        .add({
          "date": date,
          "amount": totalAmount,
          "is_repeat_expense": isRepeatExpense,
          "repeat_date": repeatDate,
          "title": title,
        });
        return doc.id;
  }

  Future editExpenses(
    String userID,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    DateTime repeatDate,
    String title,
    String id,

    String categoryID,
  ) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .doc(categoryID)
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

  Future deleteExpenses(String userID, String id, String categoryID) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .doc(categoryID)
        .collection("expenses")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getExpenses(
    String userID,
    String categoryID,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .doc(categoryID)
        .collection("expenses")
        .snapshots();
  }

  // expenses category
  Future addExpensesCategory(String userID, String title) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .add({"title": title});
  }

  Future editExpensesCategory(String userID, String title, String id) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .doc(id)
        .update({"title": title});
  }

  Future deleteExpensesCategory(String userID, String id) async {
    await _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getExpensesCategory(
    String userID,
  ) {
    return _firestore
        .collection("users")
        .doc(userID)
        .collection("expenses_category")
        .snapshots();
  }
}
