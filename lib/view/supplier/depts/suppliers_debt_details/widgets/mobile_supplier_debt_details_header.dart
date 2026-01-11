import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/depts/supplier_depts_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSupplierDebtDetailsHeader
    extends GetView<SupplierDeptsDetailsControllerImpl> {
  const MobileSupplierDebtDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(DesignTokens.radiusLarge),
          bottomRight: Radius.circular(DesignTokens.radiusLarge),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and actions row
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 20,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: DesignTokens.minTouchTarget,
                        minHeight: DesignTokens.minTouchTarget,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: IconButton(
                      onPressed: () => controller.showDeleteDeptDialog(),
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.white,
                        size: 20,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: DesignTokens.minTouchTarget,
                        minHeight: DesignTokens.minTouchTarget,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing24),

              // Header content
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacing16),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: DesignTokens.borderRadiusMedium,
                    ),
                    child: Icon(
                      Icons.business_outlined,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تفاصيل دين المورد',
                          style: DesignTokens.getDisplayMedium(
                            context,
                          ).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacing4),
                        GetBuilder<SupplierDeptsDetailsControllerImpl>(
                          builder:
                              (controller) => Text(
                                controller.deptModel?.supplier_name ??
                                    'جاري التحميل...',
                                style: DesignTokens.getBodyLarge(
                                  context,
                                ).copyWith(
                                  color: AppColors.white.withValues(alpha: 0.9),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: DesignTokens.spacing16),
            ],
          ),
        ),
      ),
    );
  }
}
