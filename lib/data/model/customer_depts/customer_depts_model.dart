import 'package:cloud_firestore/cloud_firestore.dart';

class DeptsModel {
  DateTime? bill_date;
  String? customer_id;
  String? customer_name;
  String? customer_city;
  String? id;
  double? total_price;
  DeptsModel(this.bill_date, this.customer_id, this.total_price);
  DeptsModel.formatJson(dynamic mapToJson) {
    id = mapToJson["dept_id"];
    bill_date = (mapToJson["bill_date"] as Timestamp).toDate();
    customer_id = mapToJson["customer_id"];
    customer_name = mapToJson["customer_name"];
    total_price = mapToJson["total_price"].toDouble();
    customer_city = mapToJson["customer_city"];
  }
}
