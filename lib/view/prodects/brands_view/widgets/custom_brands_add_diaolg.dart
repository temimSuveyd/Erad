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
  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(5),
    title: "إضافة العلامة التجارية",
    middleText: "",
    actions: [
      SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 20,
          children: [
            Custom_textfield(
              hintText: 'اسم العلامة التجارية',
              suffixIcon: Icons.add,
              validator: validator,
              controller: controller, onChanged: (String ) {  },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ],
    backgroundColor: AppColors.backgroundColor,
    buttonColor: AppColors.primary,
    onConfirm: () {
      onConfirm();
    },
    onCancel: () {
      Get.back();
    },
  );
}
