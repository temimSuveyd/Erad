import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

AppBar Custom_appBar({
  required String title,
  List<Widget>? actions,
  bool showBackButton = true,
  VoidCallback? onBack,
}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: showBackButton
        ? IconButton(
            onPressed: onBack ?? () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textPrimary,
              size: 22,
            ),
          )
        : null,
    actions: actions,
    backgroundColor: AppColors.surface,
    elevation: 0,
    scrolledUnderElevation: 2,
    shadowColor: AppColors.shadow.withOpacity(0.05),
    surfaceTintColor: AppColors.surface,
  );
}
