import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> customEditCategoreyTypeDialog(
  TextEditingController controller,
  String currentName,
  void Function() onConfirm,
) {
  // Set the current name in the controller
  controller.text = currentName;

  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(5),
    title: "تعديل نوع الفئة",
    middleText: "",
    actions: [
      SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 20,
          children: [
            Custom_textfield(
              hintText: 'نوع الفئة',
              suffixIcon: Icons.edit,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال نوع الفئة';
                }
                return null;
              },
              controller: controller,
              onChanged: (String value) {},
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ],
    backgroundColor: AppColors.backgroundColor,
    buttonColor: AppColors.primary,
    textConfirm: "تعديل",
    textCancel: "إلغاء",
    onConfirm: () {
      onConfirm();
    },
    onCancel: () {
      Get.back();
    },
  );
}
