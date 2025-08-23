import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:get/get.dart';

void custom_snackBar([Color? color, String? title, String? message]) {
  final context = Get.context;
  if (context == null) return;

  final snackBar = SnackBar(
    content: Text(
      message ?? "عليك إدخال جميع المعلومات",
      style: TextStyle(color: Colors.white),
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

// You need to define navigatorKey in your main.dart and pass it to MaterialApp:
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// MaterialApp(navigatorKey: navigatorKey, ...)
//
// Then import it here:
// import 'package:Erad/main.dart';
