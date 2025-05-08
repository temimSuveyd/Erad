import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_search_text_field.dart';

// ignore: non_constant_identifier_names
Future<dynamic> custom_add_categorey_dialog(
  void Function() onConfirm,
  TextEditingController controller,
  String? Function(String?)? validator,
) {
  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(5),
    title: "إضافة الفئة",
    middleText: "",
    actions: [
      SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 20,
          children: [
            Custom_textfield(
              hintText: 'اسم الفئة',
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
