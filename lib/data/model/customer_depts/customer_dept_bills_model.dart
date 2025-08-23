import 'package:cloud_firestore/cloud_firestore.dart';

class DeptBillsModel {
  String? billId;
  double? totalPrice;
  DateTime? billDate;
  String? billNo;
  String? billStatus;

  DeptBillsModel({
    this.billId,
    this.totalPrice,
    this.billDate,
    this.billNo,
    this.billStatus,
  });

  DeptBillsModel.fromJson(DocumentSnapshot json) {
    billId = json['bill_id'];
    totalPrice = json['total_price'];
    billDate = json['bill_date'].toDate();
    billNo = json['bill_no'];
    billStatus = json['bill_status'];
  }
}
