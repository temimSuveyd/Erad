import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';

class MobileSuppliersHeader extends GetView<SuppliersControllerImp> {
  const MobileSuppliersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing16,
        vertical: DesignTokens.spacing12,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderLight,
            width: DesignTokens.borderWidthThin,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الموردين',
                  style: DesignTokens.getHeadlineLarge(context).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacing4),
                GetBuilder<SuppliersControllerImp>(
                  builder:
                      (controller) => Text(
                        'إجمالي الموردين: ${controller.suppliersList.length}',
                        style: DesignTokens.getBodyMedium(
                          context,
                        ).copyWith(color: AppColors.textSecondary),
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(width: DesignTokens.spacing16),

          // Add button
          SizedBox(
            height: DesignTokens.minTouchTarget,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.show_add_Suppliers_dialog();
              },
              icon: const Icon(Icons.business_center_outlined, size: 20),
              label: Text(
                'إضافة مورد',
                style: DesignTokens.getBodyMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing16,
                  vertical: DesignTokens.spacing8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: DesignTokens.borderRadiusMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
