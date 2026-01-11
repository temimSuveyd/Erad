class CustomerDebtsModel {
  String? bill_id;
  String? customer_name;
  String? customer_city;
  double? dept_amount;
  DateTime? bill_date;

  CustomerDebtsModel({
    this.bill_id,
    this.customer_name,
    this.customer_city,
    this.dept_amount,
    this.bill_date,
  });

  CustomerDebtsModel.fromJson(Map<String, dynamic> json) {
    bill_id = json['bill_id'];
    customer_name = json['customer_name'];
    customer_city = json['customer_city'];
    dept_amount = json['dept_amount']?.toDouble();
    bill_date =
        json['bill_date'] != null ? DateTime.parse(json['bill_date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bill_id'] = bill_id;
    data['customer_name'] = customer_name;
    data['customer_city'] = customer_city;
    data['dept_amount'] = dept_amount;
    data['bill_date'] = bill_date?.toIso8601String();
    return data;
  }

  static CustomerDebtsModel formatJson(Map<String, dynamic> json) {
    return CustomerDebtsModel.fromJson(json);
  }
}
