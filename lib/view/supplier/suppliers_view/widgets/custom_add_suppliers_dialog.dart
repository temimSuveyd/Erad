import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/mobile_dialog_template.dart';

Future<dynamic> customAddSuppliersDialog(
  TextEditingController supplierNameController,
  String supplierCity,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String supplierNameHint,
  String supplierCityHint,
) {
  return showMobileDialog(
    title: "إضافة مورد جديد",
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          hintText: supplierNameHint,
          suffixIcon: Icons.business_outlined,
          validator: (p0) {
            if (p0!.isEmpty) {
              return "من فضلك أدخل اسم المورد";
            }
            return null;
          },
          controller: supplierNameController,
          onChanged: (p0) {},
        ),

        const SizedBox(height: DesignTokens.spacing16),

        CustomDropDownButton(
          value: "supplier_city",
          onChanged: (value) => onChangedCity(value),
          hint: supplierCityHint,
          items: city_data,
        ),
      ],
    ),
    actions: [
      SizedBox(
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
            "إلغاء",
            style: DesignTokens.getBodyMedium(
              Get.context!,
            ).copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),

      SizedBox(
        height: DesignTokens.minTouchTarget,
        child: ElevatedButton(
          onPressed: () {
            onConfirm();
            supplierNameController.clear();
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: DesignTokens.borderRadiusSmall,
            ),
          ),
          child: Text(
            "إضافة المورد",
            style: DesignTokens.getBodyMedium(
              Get.context!,
            ).copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ],
  );
}

// Keep the old function name for backward compatibility
Future<dynamic> Custom_add_suppliers_dialog(
  TextEditingController supplierNameController,
  String supplierCity,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String supplierNameHint,
  String supplierCityHint,
) {
  return customAddSuppliersDialog(
    supplierNameController,
    supplierCity,
    onConfirm,
    onChangedCity,
    supplierNameHint,
    supplierCityHint,
  );
}
