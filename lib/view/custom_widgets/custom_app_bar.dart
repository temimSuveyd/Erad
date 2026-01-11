import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

AppBar customAppBar({required String title, required BuildContext context}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    title: Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.textPrimary,
        size: 20,
      ),
    ),
  );
}
