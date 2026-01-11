import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/bills/suppliers_bill_add_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSupplierBillSummary extends GetView<SupplierBiilAddControllerImp> {
  const MobileSupplierBillSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierBiilAddControllerImp>(
      builder: (controller) {
        // Calculate totals
        controller.totalPriceAccount();
        controller.totalProfits();

        return Container(
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
              // Section header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing8),
                    decoration: BoxDecoration(
                      color: AppColors.infoLight,
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Icon(
                      Icons.calculate_outlined,
                      color: AppColors.info,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Text(
                    'ملخص فاتورة المورد',
                    style: DesignTokens.getHeadlineMedium(context).copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Bill details
              _buildBillDetails(context),

              const SizedBox(height: DesignTokens.spacing16),

              // Financial summary
              _buildFinancialSummary(context),

              const SizedBox(height: DesignTokens.spacing16),

              // Payment status
              _buildPaymentStatus(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context,
            'المورد',
            controller.supplier_name ?? 'غير محدد',
            Icons.business_outlined,
            AppColors.primary,
          ),
          const SizedBox(height: DesignTokens.spacing12),
          _buildDetailRow(
            context,
            'المدينة',
            controller.supplier_city ?? 'غير محدد',
            Icons.location_on_outlined,
            AppColors.info,
          ),
          const SizedBox(height: DesignTokens.spacing12),
          _buildDetailRow(
            context,
            'التاريخ',
            "${controller.bill_add_date.day}/${controller.bill_add_date.month}/${controller.bill_add_date.year}",
            Icons.calendar_today_outlined,
            AppColors.warning,
          ),
          const SizedBox(height: DesignTokens.spacing12),
          _buildDetailRow(
            context,
            'عدد المنتجات',
            '${controller.bill_prodects_list.length}',
            Icons.inventory_2_outlined,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
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

  Widget _buildFinancialSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.info, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        children: [
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي التكلفة',
                style: DesignTokens.getBodyLarge(
                  context,
                ).copyWith(color: AppColors.white),
              ),
              Text(
                '${controller.total_product_price.toStringAsFixed(0)} د.ع',
                style: DesignTokens.getBodyLarge(
                  context,
                ).copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing8),

          // Expected profits from resale
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الأرباح المتوقعة من البيع',
                style: DesignTokens.getBodyMedium(
                  context,
                ).copyWith(color: AppColors.white.withValues(alpha: 0.9)),
              ),
              Text(
                '${controller.total_product_profits.toStringAsFixed(0)} د.ع',
                style: DesignTokens.getBodyMedium(context).copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing16),

          // Divider
          Container(height: 1, color: AppColors.white.withValues(alpha: 0.3)),

          const SizedBox(height: DesignTokens.spacing16),

          // Total cost
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي المبلغ المطلوب',
                style: DesignTokens.getHeadlineMedium(
                  context,
                ).copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
              ),
              Text(
                '${controller.total_product_price.toStringAsFixed(0)} د.ع',
                style: DesignTokens.getHeadlineMedium(
                  context,
                ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatus(BuildContext context) {
    final isDebt = controller.bill_payment_type == "Religion";
    final statusColor = isDebt ? AppColors.warning : AppColors.error;
    final statusBgColor =
        isDebt ? AppColors.warningLight : AppColors.errorLight;
    final statusIcon =
        isDebt ? Icons.schedule_outlined : Icons.payments_outlined;
    final statusText =
        isDebt
            ? 'دَين - سيتم إضافته لحساب المورد'
            : 'نقدي - يجب دفع المبلغ للمورد';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: statusBgColor,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: DesignTokens.borderWidthThin,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: DesignTokens.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حالة الدفع',
                  style: DesignTokens.getBodySmall(
                    context,
                  ).copyWith(color: statusColor, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                Text(
                  statusText,
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: statusColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
