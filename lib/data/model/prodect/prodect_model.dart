import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? sales_pice;
  String? buiyng_price;
  String? profits;
  String? size;
  String? title;

  ProductModel(
    this.buiyng_price,
    this.sales_pice,
    this.size,
    this.title,
    this.profits,
  );

  ProductModel.formateJson(QueryDocumentSnapshot mapToJson) {
    title = mapToJson["product_name"];
    buiyng_price = mapToJson["product_buing_price"].toString();
    sales_pice = mapToJson["product_sales_price"].toString();
    size = mapToJson["product_size"];
    profits = mapToJson["product_profits"].toString();
  }
}
