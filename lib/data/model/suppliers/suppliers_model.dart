import 'package:cloud_firestore/cloud_firestore.dart';

class SuppliersModel {
  String? supplier_name;
  String? supplier_city;
  String? supplier_id;

  SuppliersModel(this.supplier_city, this.supplier_name,this.supplier_id);

  SuppliersModel.formatJson(QueryDocumentSnapshot mapToJson) {
    supplier_city = mapToJson["supplier_city"];
    supplier_name = mapToJson["supplier_name"];
    supplier_id = mapToJson.id;
  }
}
