import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

AppBar Custom_appBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    automaticallyImplyLeading: true,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back, color: AppColors.primary),
    ),
    backgroundColor: AppColors.backgroundColor,
  );
}
