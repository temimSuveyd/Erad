import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_drop_down_button.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/mobile_dialog_template.dart';

Future<dynamic> customAddCustomerDialog(
  TextEditingController customerNameController,
  String customerCity,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String customerNameHint,
  String customerCityHint,
) {
  return showMobileDialog(
    title: "إضافة عميل جديد",
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          hintText: customerNameHint,
          suffixIcon: Icons.person_outline,
          validator: (p0) => null,
          controller: customerNameController,
          onChanged: (p0) {},
        ),

        const SizedBox(height: DesignTokens.spacing16),

        CustomDropDownButton(
          value: "customer_city",
          onChanged: (value) => onChangedCity(value),
          hint: customerCityHint,
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
            customerNameController.clear();
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
            "إضافة العميل",
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
Future<dynamic> Custom_add_customer_dialog(
  TextEditingController customerNameController,
  String customerCity,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String customerNameHint,
  String customerCityHint,
) {
  return customAddCustomerDialog(
    customerNameController,
    customerCity,
    onConfirm,
    onChangedCity,
    customerNameHint,
    customerCityHint,
  );
}
