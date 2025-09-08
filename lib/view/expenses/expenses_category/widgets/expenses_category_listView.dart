import 'package:erad/controller/expenses/expenses_category_controller.dart';
import 'package:erad/core/class/handling_data_view.dart' show HandlingDataView;
import 'package:erad/view/expenses/expenses_category/widgets/expenses_category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesCategoryListView extends StatelessWidget {
  const ExpensesCategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesCategoryControllerImp>(
      builder:
          (controller) => HandlingDataView(
            onPressed: () => controller.getExpenses(),
            statusreqest: controller.statusreqest,
            widget: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.expensesList.length,
              itemBuilder: (context, index) {
                return ExpensesCategoryCard(
                  id: controller.expensesList[index].id,
                  title: controller.expensesList[index]["title"],
                );
              },
            ),
          ),
    );
  }
}
