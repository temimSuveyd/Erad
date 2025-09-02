import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/expenses/expenses_card_model.dart';
import 'package:erad/view/expenses/widgets/custom_expenses_card.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ExpansesListView extends StatelessWidget {
  const ExpansesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getExpenses(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.expensesList.length,
              itemBuilder:
                  (context, index) => ExpensesCard(
                    expensesModel: ExpensesCardModel.formatJson(
                      controller.expensesList[index],
                    ),
                  ),
            ),
          ),
    );
  }
}
