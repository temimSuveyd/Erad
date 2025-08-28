


import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/customer/Customer_bills_view/widgets/custom_bill_status_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> custom_bill_status_dialog(
    String bill_status,
    Function(String value) onPressed,
  ) {
    return Get.defaultDialog(
      title: "فحص حالة الفاتورة",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "الحالة الحالية: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(width: 3),
              Text(
                (bill_status == "deliveryd"
                    ? "تم التسليم"
                    : bill_status == "eliminate"
                        ? "تم الإلغاء"
                        : bill_status == "itwasFormed"
                            ? "تم التشكيل"
                            : bill_status ?? ""),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: bill_status == "deliveryd"
                      ? AppColors.green
                      : bill_status == "eliminate"
                          ? AppColors.red
                          : bill_status == "itwasFormed"
                              ? AppColors.black
                              : AppColors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text("تغيير حالة الفاتورة إلى:"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Custom_bill_status_button(
                color: AppColors.green,
                onPressed: () {
                  onPressed("deliveryd");
                  Get.back();
                },
                title: "تم التسليم",
              ),
              SizedBox(width: 10),
              Custom_bill_status_button(
                color: AppColors.red,
                onPressed: () {
                  onPressed("eliminate");
                  Get.back();
                },
                title: "تم الإلغاء",
              ),
              SizedBox(width: 10),
              Custom_bill_status_button(
                color: AppColors.primary,
                onPressed: () {
                  onPressed("itwasFormed");
                  Get.back();
                },
                title: "تم التشكيل",
              ),
            ],
          ),
        ],
      ),
      textCancel: "إغلاق",
    );
  }
