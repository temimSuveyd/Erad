import 'package:cloud_firestore/cloud_firestore.dart';


class BillModel {
  DateTime? bill_date;
  String? bill_no;
  String? customer_city;
  String? customer_id;
  String? customer_name;
  String? payment_type;
  String ? bill_id ;
  String ? bill_status ;
  double? total_price;
  double? total_earn;
  double? discount_amount ;


  BillModel(
  
    this.bill_date,
    this.bill_no,
    this.customer_city,
    this.customer_id,
    this.customer_name,
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
    customer_city = mapToJson["customer_city"];
    customer_id = mapToJson["customer_id"];
    customer_name = mapToJson["customer_name"];
    payment_type = mapToJson["paymet_type"];
    total_price = mapToJson["total_product_price"].toDouble();
    total_earn = mapToJson["total_profits"].toDouble();
    bill_status  = mapToJson["bill_status"];
    discount_amount = mapToJson["discount_amount"].toDouble();

  }
}

