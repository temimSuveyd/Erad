import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

void custom_snackBar([Color? color, String? title, String? message]) {
  final context = Get.context;
  if (context == null) return;

  final snackBar = SnackBar(
    content: Text(
      message ?? "عليك إدخال جميع المعلومات",
      style: TextStyle(color: Colors.white,fontSize: 20),
    ),
    backgroundColor: color ?? AppColors.primary,
    duration: Duration(seconds: 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      onPressed: () {},
      label: "إلغاء",
      textColor: Colors.white,
    ),

    dismissDirection: DismissDirection.endToStart,

    margin: EdgeInsets.all(10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
