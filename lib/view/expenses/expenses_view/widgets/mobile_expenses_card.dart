import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/expenses/expenses_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/expenses/expenses_card_model.dart';

class MobileExpensesCard extends GetView<ExpensesControllerImp> {
  const MobileExpensesCard({super.key, required this.expensesModel});

  final ExpensesCardModel expensesModel;

  @override
  Widget build(BuildContext context) {
    // Format date
    String formattedDate =
        "${expensesModel.date!.year}/${expensesModel.date!.month.toString().padLeft(2, '0')}/${expensesModel.date!.day.toString().padLeft(2, '0')}";

    // Repeat status
    String repeatText = expensesModel.isRepeatExpense! ? "متكرر" : "مرة واحدة";

    return Container(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusMedium,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with amount and actions
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(DesignTokens.radiusMedium),
                topRight: Radius.circular(DesignTokens.radiusMedium),
              ),
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing12),

                // Title and amount
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expensesModel.title!,
                        style: DesignTokens.getBodyLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: DesignTokens.spacing4),
                      Text(
                        '${expensesModel.amount!.toStringAsFixed(0)} د.ع',
                        style: DesignTokens.getHeadlineMedium(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Actions menu
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      controller.showEditDialog(
                        expensesModel.title ?? "",
                        expensesModel.amount ?? 0.0,
                        expensesModel.date ?? DateTime.now(),
                        expensesModel.isRepeatExpense ?? false,
                        expensesModel.repeatDate ?? DateTime.now(),
                        expensesModel.id ?? "",
                      );
                    } else if (value == 'delete') {
                      controller.showDeleteDialog(expensesModel.id!);
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text('تعديل'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 20),
                              const SizedBox(width: DesignTokens.spacing8),
                              Text('حذف'),
                            ],
                          ),
                        ),
                      ],
                  child: Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Icon(
                      Icons.more_vert,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details section
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              children: [
                // Date info
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تاريخ النفقة',
                            style: DesignTokens.getBodySmall(
                              context,
                            ).copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            formattedDate,
                            style: DesignTokens.getBodyMedium(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing12),

                // Repeat status
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color:
                            expensesModel.isRepeatExpense!
                                ? AppColors.primary.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        expensesModel.isRepeatExpense!
                            ? Icons.repeat
                            : Icons.repeat_one,
                        color:
                            expensesModel.isRepeatExpense!
                                ? AppColors.primary
                                : Colors.grey,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'نوع النفقة',
                            style: DesignTokens.getBodySmall(
                              context,
                            ).copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            repeatText,
                            style: DesignTokens.getBodyMedium(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  expensesModel.isRepeatExpense!
                                      ? AppColors.primary
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
