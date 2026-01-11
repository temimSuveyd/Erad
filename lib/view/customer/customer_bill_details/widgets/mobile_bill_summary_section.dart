import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileBillSummarySection
    extends GetView<CustomerBillDetailsControllerImp> {
  const MobileBillSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBillDetailsControllerImp>(
      builder: (controller) {
        if (controller.billModel == null) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(DesignTokens.spacing20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: DesignTokens.borderRadiusLarge,
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section title
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: DesignTokens.spacing8),
                  Text(
                    'ملخص الفاتورة',
                    style: DesignTokens.getHeadlineMedium(context).copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Summary items
              _buildSummaryRow(
                context,
                'المبلغ الإجمالي',
                '${controller.total_price?.toStringAsFixed(0) ?? '0'} د.ع',
                AppColors.textPrimary,
              ),

              const SizedBox(height: DesignTokens.spacing12),

              if (controller.discount_amount > 0) ...[
                _buildSummaryRow(
                  context,
                  'مبلغ الخصم',
                  '- ${controller.discount_amount.toStringAsFixed(0)} د.ع',
                  AppColors.warning,
                ),
                const SizedBox(height: DesignTokens.spacing12),
              ],

              _buildSummaryRow(
                context,
                'إجمالي الربح',
                '${controller.total_earn?.toStringAsFixed(0) ?? '0'} د.ع',
                AppColors.success,
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Divider
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.border,
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Final total
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: DesignTokens.borderRadiusMedium,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المبلغ النهائي',
                      style: DesignTokens.getHeadlineMedium(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(controller.total_price ?? 0).toStringAsFixed(0)} د.ع',
                      style: DesignTokens.getHeadlineLarge(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: DesignTokens.spacing16),

              // Payment status
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  color:
                      controller.billModel!.payment_type == 'monetary'
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: DesignTokens.borderRadiusMedium,
                  border: Border.all(
                    color:
                        controller.billModel!.payment_type == 'monetary'
                            ? AppColors.success.withValues(alpha: 0.2)
                            : AppColors.warning.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      controller.billModel!.payment_type == 'monetary'
                          ? Icons.check_circle_outline
                          : Icons.schedule_outlined,
                      color:
                          controller.billModel!.payment_type == 'monetary'
                              ? AppColors.success
                              : AppColors.warning,
                      size: 24,
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'حالة الدفع',
                            style: DesignTokens.getBodySmall(context).copyWith(
                              color:
                                  controller.billModel!.payment_type ==
                                          'monetary'
                                      ? AppColors.success
                                      : AppColors.warning,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing4),
                          Text(
                            controller.billModel!.payment_type == 'monetary'
                                ? 'تم الدفع نقداً'
                                : 'دين - لم يتم الدفع',
                            style: DesignTokens.getBodyLarge(context).copyWith(
                              color:
                                  controller.billModel!.payment_type ==
                                          'monetary'
                                      ? AppColors.success
                                      : AppColors.warning,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.getBodyLarge(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: DesignTokens.getBodyLarge(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
