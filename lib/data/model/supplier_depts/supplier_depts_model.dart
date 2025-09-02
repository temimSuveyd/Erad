import 'package:cloud_firestore/cloud_firestore.dart';

class DeptsModel {
  DateTime? bill_date;
  String? supplier_id;
  String? supplier_name;
  String? supplier_city;
  String? id;
  double? total_price;
  DeptsModel(this.bill_date, this.supplier_id, this.total_price);
  DeptsModel.formatJson(dynamic mapToJson) {
    id = mapToJson["dept_id"];
    bill_date = (mapToJson["bill_date"] as Timestamp).toDate();
    supplier_id = mapToJson["supplier_id"];
    supplier_name = mapToJson["supplier_name"];
    total_price = mapToJson["total_price"].toDouble();
    supplier_city = mapToJson["supplier_city"];
  }
}
