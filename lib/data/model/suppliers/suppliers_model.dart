
class SuppliersModel {
  String? supplier_name;
  String? supplier_city;
  String? supplier_id;
  int? supplier_phone;

  SuppliersModel(
    this.supplier_city,
    this.supplier_name,
    this.supplier_id,
    this.supplier_phone,
  );

  SuppliersModel.formatJson(dynamic mapToJson) {
    supplier_city = mapToJson["supplier_city"];
    supplier_name = mapToJson["supplier_name"];
    supplier_id = mapToJson.id;
    supplier_phone = 0529;
  }
}
