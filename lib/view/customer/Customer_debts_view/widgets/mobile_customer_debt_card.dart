import 'package:erad/data/model/customer_depts/customer_depts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileCustomerDebtCard extends GetView<CustomerDeptsViewControllerImp> {
  const MobileCustomerDebtCard({super.key, required this.debtModel});

  final DeptsModel debtModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: DesignTokens.spacing8,
        horizontal: DesignTokens.spacing16,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(
          color: AppColors.border,
          width: DesignTokens.borderWidthThin,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textLight.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: DesignTokens.borderRadiusMedium,
          onTap: () => controller.goTODetailsPage(debtModel.id!),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Customer Name and Debt Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            debtModel.customer_name ?? 'غير محدد',
                            style: DesignTokens.getHeadlineMedium(
                              context,
                            ).copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing12,
                        vertical: DesignTokens.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Text(
                        '${debtModel.total_price ?? 0}',
                        style: DesignTokens.getHeadlineMedium(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing12),

                // Secondary Information Row
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Text(
                      debtModel.customer_city ?? 'غير محدد',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: DesignTokens.spacing16),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Text(
                      debtModel.bill_date != null
                          ? "${debtModel.bill_date!.day}/${debtModel.bill_date!.month}/${debtModel.bill_date!.year}"
                          : 'غير محدد',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing8),

                // Debt Status Row
                Row(
                  children: [
                    Icon(
                      Icons.warning_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing8,
                        vertical: DesignTokens.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Text(
                        'دين مستحق',
                        style: DesignTokens.getBodySmall(context).copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Divider
                Container(height: 1, color: AppColors.borderLight),

                const SizedBox(height: DesignTokens.spacing12),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () => controller.goTODetailsPage(debtModel.id!),
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    label: Text(
                      'عرض التفاصيل والدفعات',
                      style: DesignTokens.getBodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
