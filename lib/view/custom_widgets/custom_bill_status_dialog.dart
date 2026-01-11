import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> custom_bill_status_dialog(
  String billStatus,
  Function(String value) onPressed,
) {
  return Get.dialog(
    Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: DesignTokens.borderRadiusMedium,
      ),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing20),
        constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Text(
              "حالة الفاتورة",
              style: DesignTokens.getHeadlineMedium(Get.context!).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: DesignTokens.spacing16),

            // Current status
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacing12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: DesignTokens.borderRadiusSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "الحالة الحالية: ",
                    style: DesignTokens.getBodyLarge(Get.context!).copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacing8,
                      vertical: DesignTokens.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(billStatus),
                      borderRadius: DesignTokens.borderRadiusSmall,
                    ),
                    child: Text(
                      _getStatusText(billStatus),
                      style: DesignTokens.getBodyMedium(Get.context!).copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: DesignTokens.spacing20),

            // Change status label
            Text(
              "تغيير حالة الفاتورة إلى:",
              style: DesignTokens.getBodyLarge(Get.context!).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: DesignTokens.spacing16),

            // Status buttons - Mobile optimized vertical layout
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      onPressed("deliveryd");
                      Get.back();
                    },
                    icon: const Icon(Icons.check_circle_outline, size: 20),
                    label: Text(
                      "تم التسليم",
                      style: DesignTokens.getBodyMedium(
                        Get.context!,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing8),

                SizedBox(
                  width: double.infinity,
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      onPressed("eliminate");
                      Get.back();
                    },
                    icon: const Icon(Icons.cancel_outlined, size: 20),
                    label: Text(
                      "تم الإلغاء",
                      style: DesignTokens.getBodyMedium(
                        Get.context!,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: DesignTokens.spacing8),

                SizedBox(
                  width: double.infinity,
                  height: DesignTokens.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      onPressed("itwasFormed");
                      Get.back();
                    },
                    icon: const Icon(Icons.build_outlined, size: 20),
                    label: Text(
                      "تم التشكيل",
                      style: DesignTokens.getBodyMedium(
                        Get.context!,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: DesignTokens.borderRadiusSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: DesignTokens.spacing20),

            // Cancel button
            SizedBox(
              width: double.infinity,
              height: DesignTokens.minTouchTarget,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: BorderSide(
                    color: AppColors.border,
                    width: DesignTokens.borderWidthThin,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: DesignTokens.borderRadiusSmall,
                  ),
                ),
                child: Text(
                  "إغلاق",
                  style: DesignTokens.getBodyMedium(
                    Get.context!,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

String _getStatusText(String billStatus) {
  switch (billStatus) {
    case "deliveryd":
      return "تم التسليم";
    case "eliminate":
      return "تم الإلغاء";
    case "itwasFormed":
      return "تم التشكيل";
    default:
      return "غير محدد";
  }
}

Color _getStatusColor(String billStatus) {
  switch (billStatus) {
    case "deliveryd":
      return AppColors.success;
    case "eliminate":
      return AppColors.error;
    case "itwasFormed":
      return AppColors.primary;
    default:
      return AppColors.textSecondary;
  }
}
