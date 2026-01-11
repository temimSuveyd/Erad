import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileExpensesSummary extends GetView<ExpensesControllerImp> {
  const MobileExpensesSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesControllerImp>(
      builder: (controller) {
        // Calculate statistics
        final totalExpenses = controller.expensesList.length;
        final totalAmount = controller.expensesTotalAmount;
        final repeatExpenses =
            controller.expensesList
                .where((expense) => expense.data()['isRepeatExpense'] == true)
                .length;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(DesignTokens.spacing20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: DesignTokens.borderRadiusMedium,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Icon(
                      Icons.analytics_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ملخص النفقات',
                          style: DesignTokens.getHeadlineMedium(
                            context,
                          ).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'إحصائيات شاملة',
                          style: DesignTokens.getBodyMedium(
                            context,
                          ).copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Total amount card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(DesignTokens.spacing20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: DesignTokens.borderRadiusMedium,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: AppColors.white,
                          size: 28,
                        ),
                        const SizedBox(width: DesignTokens.spacing8),
                        Text(
                          'إجمالي النفقات',
                          style: DesignTokens.getBodyLarge(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Text(
                      '${totalAmount.toStringAsFixed(0)} د.ع',
                      style: DesignTokens.getDisplayMedium(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Statistics grid
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'عدد النفقات',
                      '$totalExpenses',
                      Icons.receipt_outlined,
                      AppColors.primary.withOpacity(0.1),
                      AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'النفقات المتكررة',
                      '$repeatExpenses',
                      Icons.repeat,
                      AppColors.primary.withOpacity(0.1),
                      AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color backgroundColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: DesignTokens.borderRadiusMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: DesignTokens.spacing8),
              Expanded(
                child: Text(
                  label,
                  style: DesignTokens.getBodySmall(context).copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            value,
            style: DesignTokens.getHeadlineMedium(
              context,
            ).copyWith(color: iconColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
