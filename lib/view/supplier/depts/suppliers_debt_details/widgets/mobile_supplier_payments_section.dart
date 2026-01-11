import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/depts/supplier_depts_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSupplierPaymentsSection
    extends GetView<SupplierDeptsDetailsControllerImpl> {
  const MobileSupplierPaymentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierDeptsDetailsControllerImpl>(
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
                // Section header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(DesignTokens.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.payments_outlined,
                        color: AppColors.success,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Text(
                        'الدفعات المسددة للمورد',
                        style: DesignTokens.getHeadlineMedium(context).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacing12,
                        vertical: DesignTokens.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Text(
                        '${controller.paymentsList.length}',
                        style: DesignTokens.getBodyMedium(context).copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing16),

                // Add payment button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => controller.showAddPaymentDialog(),
                    icon: Icon(Icons.add, size: 20),
                    label: Text('إضافة دفعة للمورد'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignTokens.spacing12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Payments list
                if (controller.paymentsList.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.paymentsList.length,
                    separatorBuilder:
                        (context, index) =>
                            const SizedBox(height: DesignTokens.spacing12),
                    itemBuilder: (context, index) {
                      final paymentDoc = controller.paymentsList[index];
                      return _buildPaymentCard(context, paymentDoc, index);
                    },
                  )
                else
                  _buildEmptyState(context),
              ],
            ),
          ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext context,
    dynamic paymentDoc,
    int index,
  ) {
    // DocumentSnapshot'ı Map'e çevir
    final payment = paymentDoc.data() as Map<String, dynamic>;
    final paymentDate = payment['payment_date']?.toDate() as DateTime?;
    final paymentId = paymentDoc.id ?? '';

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Icon(Icons.payment, color: AppColors.success, size: 16),
              ),
              const SizedBox(width: DesignTokens.spacing12),
              Expanded(
                child: Text(
                  'دفعة رقم ${index + 1}',
                  style: DesignTokens.getBodyLarge(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing8,
                  vertical: DesignTokens.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: DesignTokens.borderRadiusSmall,
                ),
                child: Text(
                  '${payment['total_price'] ?? 0} د.ع',
                  style: DesignTokens.getBodyMedium(context).copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: DesignTokens.spacing12),

          // Payment details
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.textSecondary,
                size: 16,
              ),
              const SizedBox(width: DesignTokens.spacing8),
              Text(
                paymentDate != null
                    ? "${paymentDate.day}/${paymentDate.month}/${paymentDate.year}"
                    : 'غير محدد',
                style: DesignTokens.getBodyMedium(
                  context,
                ).copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.showDeletePayment(paymentId),
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 20,
                ),
                constraints: const BoxConstraints(
                  minWidth: DesignTokens.minTouchTarget,
                  minHeight: DesignTokens.minTouchTarget,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.spacing32),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: DesignTokens.borderRadiusSmall,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacing16),
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payments_outlined,
              color: AppColors.warning,
              size: 32,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            'لا توجد دفعات للمورد',
            style: DesignTokens.getHeadlineMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            'لم يتم تسديد أي دفعات للمورد في هذا النطاق الزمني',
            style: DesignTokens.getBodyMedium(
              context,
            ).copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
