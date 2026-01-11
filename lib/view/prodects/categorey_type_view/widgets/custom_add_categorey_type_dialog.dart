  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> custom_add_categorey_type_dialog(
    TextEditingController controller,
    void Function() onConfirm,
  ) {
    return Get.defaultDialog(
      title: "إضافة نوع الفئة",
      middleText: "",
      backgroundColor: AppColors.background,
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              CustomTextField(
                hintText: "نوع الفئة",
                suffixIcon: Icons.add,
                validator: (p0) {
                  return null;
                },
                controller: controller, onChanged: (String ) {  },
              ),
            ],
          ),
        ),
      ],

      buttonColor: AppColors.primary,
      onConfirm: () {
        onConfirm();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
