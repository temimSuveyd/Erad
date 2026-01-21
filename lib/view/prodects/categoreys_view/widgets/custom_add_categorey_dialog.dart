import 'package:erad/core/constans/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

// ignore: non_constant_identifier_names
Future<dynamic> custom_add_categorey_dialog(
  void Function() onConfirm,
  TextEditingController controller,
  String? Function(String?)? validator,
) {
  final isMobile = DesignTokens.isMobile(Get.context!);

  return Get.dialog(
    Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isMobile ? Get.width * 0.9 : 400,
        constraints: BoxConstraints(
          maxWidth: isMobile ? Get.width * 0.9 : 400,
          minWidth: isMobile ? Get.width * 0.8 : 350,
        ),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.category_outlined,
                  color: AppColors.primary,
                  size: isMobile ? 24 : 28,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "إضافة فئة جديدة",
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                    size: isMobile ? 20 : 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),

            SizedBox(height: isMobile ? 20 : 24),

            // Content
            CustomTextField(
              hintText: 'اسم الفئة',
              suffixIcon: Icons.category,
              validator: validator,
              controller: controller,
              onChanged: (value) {},
            ),

            SizedBox(height: isMobile ? 24 : 32),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[400]!),
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 12 : 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 12 : 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'إضافة',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
