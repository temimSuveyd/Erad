import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:intl/intl.dart';

class MobileBillInfoCard extends GetView<CustomerBillDetailsControllerImp> {
  const MobileBillInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBillDetailsControllerImp>(
      builder: (controller) {
        if (controller.billModel == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final bill = controller.billModel!;
        final dateFormat = DateFormat('dd/MM/yyyy', 'ar');

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
              Text(
                'معلومات الفاتورة',
                style: DesignTokens.getHeadlineMedium(context).copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Customer info
              _buildInfoRow(
                context,
                'العميل',
                bill.customer_name ?? '',
                Icons.person_outline,
              ),

              const SizedBox(height: DesignTokens.spacing16),

              _buildInfoRow(
                context,
                'المدينة',
                bill.customer_city ?? '',
                Icons.location_on_outlined,
              ),

              const SizedBox(height: DesignTokens.spacing16),

              _buildInfoRow(
                context,
                'تاريخ الفاتورة',
                bill.bill_date != null
                    ? dateFormat.format(bill.bill_date!)
                    : '',
                Icons.calendar_today_outlined,
              ),

              const SizedBox(height: DesignTokens.spacing16),

              _buildInfoRow(
                context,
                'طريقة الدفع',
                bill.payment_type == 'monetary' ? 'نقدي' : 'دين',
                bill.payment_type == 'monetary'
                    ? Icons.attach_money_rounded
                    : Icons.money_off_csred_outlined,
                valueColor:
                    bill.payment_type == 'monetary'
                        ? AppColors.success
                        : AppColors.warning,
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Divider
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.border,
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Financial summary
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryItem(
                      context,
                      'إجمالي الفاتورة',
                      '${bill.total_price?.toStringAsFixed(0) ?? '0'} د.ع',
                      AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing16),
                  Expanded(
                    child: _buildSummaryItem(
                      context,
                      'إجمالي الربح',
                      '${bill.total_earn?.toStringAsFixed(0) ?? '0'} د.ع',
                      AppColors.success,
                    ),
                  ),
                ],
              ),

              if (controller.discount_amount > 0) ...[
                const SizedBox(height: DesignTokens.spacing16),
                _buildSummaryItem(
                  context,
                  'مبلغ الخصم',
                  '${controller.discount_amount.toStringAsFixed(0)} د.ع',
                  AppColors.warning,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryLighter,
            borderRadius: DesignTokens.borderRadiusSmall,
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: DesignTokens.getBodySmall(
                  context,
                ).copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: DesignTokens.spacing4),
              Text(
                value,
                style: DesignTokens.getBodyLarge(context).copyWith(
                  color: valueColor ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: DesignTokens.borderRadiusMedium,
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: DesignTokens.getBodySmall(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            value,
            style: DesignTokens.getHeadlineMedium(
              context,
            ).copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
