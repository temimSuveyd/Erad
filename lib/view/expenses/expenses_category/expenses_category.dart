import 'package:erad/controller/expenses/expenses_category_controller.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/expenses/expenses_category/widgets/custom_FloatingActionButton.dart';
import 'package:erad/view/expenses/expenses_category/widgets/expenses_category_listView.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:get/get.dart';

class ExpensesCategoryPage extends StatelessWidget {
  const ExpensesCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExpensesCategoryControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "فئة الإنفاق"),
      floatingActionButton: CustomFloatingActionButton(),

      body: ExpensesCategoryListView(),
    );
  }
}
