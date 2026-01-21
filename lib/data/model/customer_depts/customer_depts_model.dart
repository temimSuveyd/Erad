class DeptsModel {
  DateTime? bill_date;
  String? customer_id;
  String? customer_name;
  String? customer_city;
  String? id;
  double? total_price;
  DeptsModel(this.bill_date, this.customer_id, this.total_price,this.customer_city,this.customer_name,this.id);
  DeptsModel.formatJson(dynamic mapToJson) {
    id = mapToJson["id"];
    bill_date =  DateTime.parse(mapToJson["bill_date"]);
    customer_id = mapToJson["customer_id"];
    customer_name = mapToJson["customer_name"];
    total_price = mapToJson["total_price"].toDouble();
    customer_city = mapToJson["customer_city"];
  }
}
