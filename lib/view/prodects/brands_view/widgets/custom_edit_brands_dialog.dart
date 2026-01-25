import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> customEditBrandsDialog(
  void Function() onConfirm,
  TextEditingController controller,
  String currentName,
  String? Function(String?)? validator,
) {
  // Set the current name in the controller
  controller.text = currentName;

  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(5),
    title: "تعديل العلامة التجارية",
    middleText: "",
    actions: [
      SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 20,
          children: [
            Custom_textfield(
              hintText: 'اسم العلامة التجارية',
              suffixIcon: Icons.edit,
              validator: validator,
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
