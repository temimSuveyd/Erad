import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersModel {
  String? customer_name;
  String? customer_city;
  String? customer_id;

  CustomersModel(this.customer_city, this.customer_name,this.customer_id);

  CustomersModel.formatJson(QueryDocumentSnapshot mapToJson) {
    customer_city = mapToJson["customer_city"];
    customer_name = mapToJson["customer_name"];
    customer_id = mapToJson.id;
  }
}
