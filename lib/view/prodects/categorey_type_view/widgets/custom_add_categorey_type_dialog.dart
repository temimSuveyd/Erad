  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';

Future<dynamic> custom_add_categorey_type_dialog(
    TextEditingController controller,
    void Function() onConfirm,
  ) {
    return Get.defaultDialog(
      title: "إضافة نوع الفئة",
      middleText: "",
      backgroundColor: AppColors.backgroundColor,
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Custom_textfield(
                hintText: "نوع الفئة",
                suffixIcon: Icons.add,
                validator: (p0) {},
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