import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/images.dart';
import 'package:flutter/material.dart';

AppBar Custom_home_appBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.primary,
    centerTitle: true,

    actions: [
      SizedBox(width: 15),
      SizedBox(
        height: 45,
        width: 45,
        child: Image.asset(AppImages.logo, fit: BoxFit.cover),
      ),

      SizedBox(width: 10),
      Text(
        "إراد",
        style: TextStyle(
          fontSize: 24,
          color: AppColors.wihet,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
    ],
  );
}
