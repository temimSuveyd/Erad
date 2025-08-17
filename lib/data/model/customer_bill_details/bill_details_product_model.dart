import 'package:cloud_firestore/cloud_firestore.dart';

class BillDetailsProductsModel {
  String? product_name;
  int? product_number;
  int? product_price;
  int? prodect_totla_price;
  String ? id ;

  BillDetailsProductsModel(this.product_name, this.product_number, this.product_price, this.id);
  BillDetailsProductsModel.formatJson(DocumentSnapshot mapToJson) {
    product_name = mapToJson["product_name"];
    product_price = mapToJson["product_price"];
    product_number = mapToJson["product_number"];
    prodect_totla_price = mapToJson["total_product_price"];
    id = mapToJson.id;
  }
}
