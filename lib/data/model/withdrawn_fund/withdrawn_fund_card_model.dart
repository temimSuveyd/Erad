
class WithdrawnFundCardModel {
  DateTime? date;
  DateTime? repeatDate;
  double? amount;
  bool? isRepeatWithdrawnFund;
  String? id;

  WithdrawnFundCardModel(
    this.amount,
    this.date,
    this.isRepeatWithdrawnFund,
    this.repeatDate,
    this.id,
  );

  WithdrawnFundCardModel.formatJson(dynamic queryToJson) {
    date = queryToJson["date"].toDate();
    amount = queryToJson["amount"];
    isRepeatWithdrawnFund = queryToJson["is_repeat_withdrawn_fund"];
    repeatDate = queryToJson["repeat_date"].toDate();
    id = queryToJson.id;
  }
}


