class BillProductsModel {
  String? product_name;
  int? product_number;
  int? product_price;
  int? prodect_totla_price;

  BillProductsModel(this.product_name, this.product_number, this.product_price);
  BillProductsModel.formaToJson(dynamic mapToJson) {
    product_name = mapToJson["product_name"];
    product_price = mapToJson["product_price"];
    product_number = mapToJson["product_number"];
    prodect_totla_price = mapToJson["total_product_price"];
  }
}
