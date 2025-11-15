import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

AppBar Custom_appBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    automaticallyImplyLeading: true,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back, color: AppColors.black),
    ),
    backgroundColor: Colors.transparent,
  );
}
