


import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_bill_status_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> custom_bill_status_dialog(
    String billStatus,
    Function(String value) onPressed,
  ) {
    return Get.defaultDialog(
      backgroundColor: AppColors.backgroundColor,
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
                (billStatus == "deliveryd"
                    ? "تم التسليم"
                    : billStatus == "eliminate"
                        ? "تم الإلغاء"
                        : billStatus == "itwasFormed"
                            ? "تم التشكيل"
                            : billStatus ?? ""),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: billStatus == "deliveryd"
                      ? AppColors.green
                      : billStatus == "eliminate"
                          ? AppColors.red
                          : billStatus == "itwasFormed"
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
