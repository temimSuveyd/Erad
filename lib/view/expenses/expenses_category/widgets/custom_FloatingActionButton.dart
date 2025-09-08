import 'package:erad/controller/expenses/expenses_category_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFloatingActionButton
    extends GetView<ExpensesCategoryControllerImp> {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.showaddExpensesCategoryDailog();
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
