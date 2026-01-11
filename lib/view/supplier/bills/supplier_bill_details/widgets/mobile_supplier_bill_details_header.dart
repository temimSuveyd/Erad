import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/bills/suppliers_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSupplierBillDetailsHeader
    extends GetView<SuppliersBillDetailsControllerImp> {
  const MobileSupplierBillDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.spacing16,
        DesignTokens.spacing48,
        DesignTokens.spacing16,
        DesignTokens.spacing16,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(DesignTokens.radiusLarge),
          bottomRight: Radius.circular(DesignTokens.radiusLarge),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header with back button and title
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: DesignTokens.minTouchTarget,
                    height: DesignTokens.minTouchTarget,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing16),
                Expanded(
                  child: Text(
                    'تفاصيل فاتورة المورد',
                    style: DesignTokens.getHeadlineLarge(context).copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: DesignTokens.minTouchTarget),
              ],
            ),

            const SizedBox(height: DesignTokens.spacing24),

            // Bill number and status
            GetBuilder<SuppliersBillDetailsControllerImp>(
              builder: (controller) {
                if (controller.supplierBillModel == null) {
                  return const SizedBox.shrink();
                }

                return Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.15),
                    borderRadius: DesignTokens.borderRadiusMedium,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'رقم الفاتورة',
                            style: DesignTokens.getBodySmall(context).copyWith(
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing4),
                          Text(
                            controller.supplierBillModel!.bill_no ?? '',
                            style: DesignTokens.getHeadlineMedium(
                              context,
                            ).copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacing12,
                          vertical: DesignTokens.spacing6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              controller.supplierBillModel!.payment_type ==
                                      'monetary'
                                  ? AppColors.success
                                  : AppColors.warning,
                          borderRadius: DesignTokens.borderRadiusSmall,
                        ),
                        child: Text(
                          controller.supplierBillModel!.payment_type ==
                                  'monetary'
                              ? 'نقدي'
                              : 'دين',
                          style: DesignTokens.getBodySmall(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
