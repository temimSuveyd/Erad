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

  ProductModel.formateJson(dynamic mapToJson) {
    title = mapToJson["product_name"];
    buiyng_price = mapToJson["product_buying_price"].toString();
    sales_pice = mapToJson["product_sales_price"].toString();
    size = mapToJson["product_size"];
    profits = mapToJson["product_profits"].toString();
  }
}
