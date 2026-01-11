import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/depts/supplier_depts_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSupplierBillsSection
    extends GetView<SupplierDeptsDetailsControllerImpl> {
  const MobileSupplierBillsSection({super.key});

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
                        color: AppColors.warningLight,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        color: AppColors.warning,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Text(
                        'فواتير المورد المستحقة',
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
                        color: AppColors.warningLight,
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                      child: Text(
                        '${controller.deptsList.length}',
                        style: DesignTokens.getBodyMedium(context).copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: DesignTokens.spacing20),

                // Bills list
                if (controller.deptsList.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.deptsList.length,
                    separatorBuilder:
                        (context, index) =>
                            const SizedBox(height: DesignTokens.spacing12),
                    itemBuilder: (context, index) {
                      final billDoc = controller.deptsList[index];
                      return _buildBillCard(context, billDoc, index);
                    },
                  )
                else
                  _buildEmptyState(context),
              ],
            ),
          ),
    );
  }

  Widget _buildBillCard(BuildContext context, dynamic billDoc, int index) {
    // DocumentSnapshot'ı Map'e çevir
    final bill = billDoc.data() as Map<String, dynamic>;
    final billDate = bill['bill_date']?.toDate() as DateTime?;

    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: DesignTokens.borderRadiusSmall,
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: DesignTokens.borderRadiusSmall,
        onTap: () => controller.goToBillDetails(bill['bill_id'] ?? ''),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing8),
                  decoration: BoxDecoration(
                    color: AppColors.warningLight,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Icon(
                    Icons.receipt_outlined,
                    color: AppColors.warning,
                    size: 16,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing12),
                Expanded(
                  child: Text(
                    'فاتورة رقم: ${bill['bill_no'] ?? 'غير محدد'}',
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
                    color: AppColors.warningLight,
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                  child: Text(
                    '${bill['total_price'] ?? 0} د.ع',
                    style: DesignTokens.getBodyMedium(context).copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: DesignTokens.spacing12),

            // Bill details
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: DesignTokens.spacing8),
                Text(
                  billDate != null
                      ? "${billDate.day}/${billDate.month}/${billDate.year}"
                      : 'غير محدد',
                  style: DesignTokens.getBodyMedium(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
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
              color: AppColors.successLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: AppColors.success,
              size: 32,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing16),
          Text(
            'لا توجد فواتير مستحقة',
            style: DesignTokens.getHeadlineMedium(context).copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            'جميع فواتير المورد في هذا النطاق الزمني تم سدادها',
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
