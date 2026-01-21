import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

// ignore: non_constant_identifier_names
Future<dynamic> custom_add_brands_dialog(
  void Function() onConfirm,
  TextEditingController controller,
  String? Function(String?)? validator,
) {
  return Get.dialog(
    Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Ekran boyutuna göre responsive tasarım
          final screenWidth = MediaQuery.of(context).size.width;
          final isDesktop = screenWidth > 600;
          final dialogWidth =
              isDesktop
                  ? screenWidth *
                      0.4 // Desktop için %40
                  : screenWidth * 0.9; // Mobil için %90

          return Container(
            width: dialogWidth,
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 500 : double.infinity,
              minWidth: isDesktop ? 400 : 280,
            ),
            padding: EdgeInsets.all(isDesktop ? 32 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Başlık
                Row(
                  children: [
                    Icon(
                      Icons.branding_watermark_outlined,
                      color: AppColors.primary,
                      size: isDesktop ? 28 : 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "إضافة العلامة التجارية",
                        style: TextStyle(
                          fontSize: isDesktop ? 24 : 20,
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
                        size: isDesktop ? 24 : 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),

                SizedBox(height: isDesktop ? 32 : 24),

                // Text Field
                CustomTextField(
                  hintText: 'اسم العلامة التجارية',
                  suffixIcon: Icons.branding_watermark,
                  validator: validator,
                  controller: controller,
                  onChanged: (value) {},
                ),

                SizedBox(height: isDesktop ? 32 : 24),

                // Butonlar
                isDesktop
                    ? _buildDesktopButtons(onConfirm)
                    : _buildMobileButtons(onConfirm),
              ],
            ),
          );
        },
      ),
    ),
    barrierDismissible: true,
  );
}

// Desktop için yan yana butonlar
Widget _buildDesktopButtons(void Function() onConfirm) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () => Get.back(),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "إلغاء",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),

      const SizedBox(width: 16),

      ElevatedButton(
        onPressed: onConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "إضافة",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

// Mobil için alt alta butonlar
Widget _buildMobileButtons(void Function() onConfirm) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: onConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "إضافة",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

      const SizedBox(height: 12),

      TextButton(
        onPressed: () => Get.back(),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "إلغاء",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    ],
  );
}
