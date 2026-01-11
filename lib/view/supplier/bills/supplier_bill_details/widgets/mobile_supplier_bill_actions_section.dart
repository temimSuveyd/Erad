import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/bills/suppliers_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSupplierBillActionsSection
    extends GetView<SuppliersBillDetailsControllerImp> {
  const MobileSupplierBillActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuppliersBillDetailsControllerImp>(
      builder: (controller) {
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
                    Icons.settings_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: DesignTokens.spacing8),
                  Text(
                    'إجراءات الفاتورة',
                    style: DesignTokens.getHeadlineMedium(context).copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing20),

              // Action buttons
              Column(
                children: [
                  // First row
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          context,
                          'خصم على الفاتورة',
                          Icons.discount_outlined,
                          AppColors.warning,
                          () => controller.discountOnSupplierBill(),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacing12),
                      Expanded(
                        child: _buildActionButton(
                          context,
                          'طباعة PDF',
                          Icons.print_outlined,
                          AppColors.info,
                          () => controller.createSupplierBillPdf(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: DesignTokens.spacing12),

                  // Second row
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          context,
                          'تغيير طريقة الدفع',
                          Icons.payments_outlined,
                          AppColors.primary,
                          () => controller.showEditSupplierPaymentTypeDialog(),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacing12),
                      Expanded(
                        child: _buildActionButton(
                          context,
                          'حذف الفاتورة',
                          Icons.delete_outline,
                          AppColors.error,
                          () => controller.showDeleteSupplierBillDialog(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: DesignTokens.borderRadiusMedium,
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: DesignTokens.spacing8),
            Text(
              title,
              style: DesignTokens.getBodySmall(
                context,
              ).copyWith(color: color, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
