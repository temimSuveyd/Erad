import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesData {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addExpenses(
    String user_email,
    DateTime date,
    double totalAmount,
    bool isRepeatExpense,
    String dateType,
    String title ,
  ) async{
  await  _firestore.collection("users").doc(user_email).collection("expenses").add({
      "date": date,
      "amount": totalAmount,
      "is_repeat_expense": isRepeatExpense,
      "date_type": dateType,
      "title" : title ,
    });
  }

 Stream<QuerySnapshot<Map<String, dynamic>>> getExpenses(String user_email) {
  return  _firestore
        .collection("users")
        .doc(user_email)
        .collection("expenses")
        .snapshots();
  }
}
