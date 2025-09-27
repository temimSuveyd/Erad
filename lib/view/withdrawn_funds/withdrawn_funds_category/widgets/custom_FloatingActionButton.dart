import 'package:erad/controller/withdrawn_funds/withdrawn_funds_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFloatingActionButton
    extends GetView<WithdrawnFundsCategoryControllerImp> {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.showaddWithdrawnFundsCategoryDailog();
      },
      tooltip: "Ekle",
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        "إضافة فئة مصروف",
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
