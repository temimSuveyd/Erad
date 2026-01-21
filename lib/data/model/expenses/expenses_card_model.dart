
class ExpensesCardModel {
  DateTime? date;
  String? title;
  DateTime? repeatDate;
  double? amount;
  bool? isRepeatExpense;
  String? id;

  ExpensesCardModel(
    this.amount,
    this.date,
    this.isRepeatExpense,
    this.title,
    this.repeatDate,
    this.id,
  );

  ExpensesCardModel.formatJson(dynamic queryToJson) {
    date = queryToJson["date"].toDate();
    title = queryToJson["title"];
    amount = queryToJson["amount"];
    isRepeatExpense = queryToJson["is_repeat_expense"];
    repeatDate = queryToJson["repeat_date"].toDate();
    id = queryToJson.id;
  }
}
