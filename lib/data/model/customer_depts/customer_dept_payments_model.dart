
class DeptPaymentsModel {
  String? paymentId;
  double? paymentPrice;
  DateTime? paymentDate;

  DeptPaymentsModel({this.paymentId, this.paymentPrice, this.paymentDate});

  DeptPaymentsModel.fromJson(dynamic json) {
    paymentId = json.id;
    paymentPrice = json['total_price'];
    paymentDate = json['payment_date'].toDate();
  }
}
