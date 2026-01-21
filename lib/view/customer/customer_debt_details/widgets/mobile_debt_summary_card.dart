import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileDebtSummaryCard extends GetView<CustomerDeptsDetailsControllerImp> {
  const MobileDebtSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsDetailsControllerImp>(
      builder:
          (controller) => Container(
            padding: const EdgeInsets.all(DesignTokens.spacing20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: DesignTokens.borderRadiusMedium,
              border: Border.all(
                color: AppColors.border,
                width: DesignTokens.borderWidthThin,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLighter,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Text(
                      'ملخص الدين',
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Customer info
                if (controller.deptModel != null) ...[
                  _buildInfoRow(
                    context,
                    'العميل',
                    controller.deptModel!.customer_name ?? 'غير محدد',
                    Icons.person_outline,
                    AppColors.primary,
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _buildInfoRow(
                    context,
                    'المدينة',
                    controller.deptModel!.customer_city ?? 'غير محدد',
                    Icons.location_on_outlined,
                    AppColors.primary,
                  ),
                  const SizedBox(height: DesignTokens.spacing20),
                ],

                // Financial summary
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'إجمالي الديون',
                            style: DesignTokens.getBodyLarge(
                              context,
                            ).copyWith(color: AppColors.white),
                          ),
                          Text(
                            '${_calculateTotalDebts(controller)} د.ع',
                            style: DesignTokens.getBodyLarge(context).copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DesignTokens.spacing8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'إجمالي المدفوعات',
                            style: DesignTokens.getBodyMedium(context).copyWith(
                              color: AppColors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          Text(
                            '${_calculateTotalPayments(controller)} د.ع',
                            style: DesignTokens.getBodyMedium(context).copyWith(
                              color: AppColors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DesignTokens.spacing16),
                      Container(
                        height: 1,
                        color: AppColors.white.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: DesignTokens.spacing16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المبلغ المتبقي',
                            style: DesignTokens.getHeadlineMedium(
                              context,
                            ).copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${controller.remainingDebtAamount.toStringAsFixed(0)} د.ع',
                            style: DesignTokens.getHeadlineMedium(
                              context,
                            ).copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Status indicator
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacing12),
                  decoration: BoxDecoration(
                    color:
                        controller.remainingDebtAamount > 0
                            ? AppColors.errorLight
                            : AppColors.successLight,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        controller.remainingDebtAamount > 0
                            ? Icons.warning_outlined
                            : Icons.check_circle_outline,
                        color:
                            controller.remainingDebtAamount > 0
                                ? AppColors.error
                                : AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: DesignTokens.spacing8),
                      Expanded(
                        child: Text(
                          controller.remainingDebtAamount > 0
                              ? 'يوجد دين مستحق'
                              : 'تم سداد الدين بالكامل',
                          style: DesignTokens.getBodyMedium(context).copyWith(
                            color:
                                controller.remainingDebtAamount > 0
                                    ? AppColors.error
                                    : AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(DesignTokens.spacing6),
          decoration: BoxDecoration(
            color: AppColors.withOpacity(color, 0.1),
            borderRadius: DesignTokens.borderRadiusSmall,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: DesignTokens.getBodyMedium(
                  context,
                ).copyWith(color: AppColors.textSecondary),
              ),
              Text(
                value,
                style: DesignTokens.getBodyMedium(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateTotalDebts(CustomerDeptsDetailsControllerImp controller) {
    return controller.calculateTotalDebts();
  }

  double _calculateTotalPayments(CustomerDeptsDetailsControllerImp controller) {
    return controller.calculateTotalPayments();
  }
}
