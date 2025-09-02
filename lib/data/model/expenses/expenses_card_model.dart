class ExpensesCardModel {
  DateTime? date;
  String? title;
  String? dateType;

  double? amount;
  bool? isRepeatExpense;

  ExpensesCardModel(this.amount, this.date, this.isRepeatExpense, this.title);

  ExpensesCardModel.formatJson(dynamic queryToJson) {
    date = queryToJson["date"].toDate();
    title = queryToJson["title"];
    amount = queryToJson["amount"];
    isRepeatExpense = queryToJson["is_repeat_expense"];
    dateType = queryToJson["date_type"];
  }
}
