import 'package:cloud_firestore/cloud_firestore.dart';


class BillModel {
  DateTime? bill_date;
  String? bill_no;
  String? supplier_city;
  String? supplier_id;
  String? supplier_name;
  String? payment_type;
  String ? bill_id ;
  String ? bill_status ;
  double? total_price;
  double? total_earn;
  double? discount_amount ;


  BillModel(
  
    this.bill_date,
    this.bill_no,
    this.supplier_city,
    this.supplier_id,
    this.supplier_name,
    this.payment_type,
    this.total_earn,
    this.total_price,
    this.bill_id,
    this.bill_status,
    this.discount_amount,
  );

  BillModel.formatJson(dynamic mapToJson) {
    bill_id = mapToJson.id;
    bill_date = (mapToJson["bill_date"] as Timestamp).toDate();
    bill_no = mapToJson["bill_no"];
    supplier_city = mapToJson["supplier_city"];
    supplier_id = mapToJson["supplier_id"];
    supplier_name = mapToJson["supplier_name"];
    payment_type = mapToJson["paymet_type"];
    total_price = mapToJson["total_product_price"].toDouble();
    total_earn = mapToJson["total_profits"].toDouble();
    bill_status  = mapToJson["bill_status"];
    discount_amount = mapToJson["discount_amount"].toDouble();

  }
}

