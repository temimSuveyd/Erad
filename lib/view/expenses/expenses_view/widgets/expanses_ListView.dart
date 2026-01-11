import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/class/handling_data.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/expenses/expenses_card_model.dart';
import 'package:erad/view/expenses/expenses_view/widgets/custom_expenses_card.dart';
import 'package:erad/view/expenses/expenses_view/widgets/mobile_expenses_card.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ExpansesListView extends StatelessWidget {
  const ExpansesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesControllerImp>(
      builder: (controller) {
        // Handle different states
        if (controller.statusreqest == Statusreqest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statusreqest == Statusreqest.faliure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: DesignTokens.spacing16),
                Text(
                  'حدث خطأ في تحميل البيانات',
                  style: DesignTokens.getBodyLarge(context),
                ),
                const SizedBox(height: DesignTokens.spacing16),
                ElevatedButton(
                  onPressed: () => controller.getExpenses(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (controller.statusreqest == Statusreqest.success) {
          if (controller.expensesList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spacing16),
                  Text(
                    'لا توجد نفقات',
                    style: DesignTokens.getBodyLarge(context),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.expensesList.length,
            itemBuilder: (context, index) {
              final isMobile = DesignTokens.isMobile(context);
              final expensesModel = ExpensesCardModel.formatJson(
                controller.expensesList[index],
              );

              if (isMobile) {
                // Use mobile card for mobile devices
                return MobileExpensesCard(expensesModel: expensesModel);
              } else {
                // Use desktop card for larger screens
                return ExpensesCard(expensesModel: expensesModel);
              }
            },
          );
        }

        // Default case
        return const SizedBox.shrink();
      },
    );
  }
}
