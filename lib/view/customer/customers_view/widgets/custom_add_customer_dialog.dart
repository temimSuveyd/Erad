import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/function/validatorInpot.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> Custom_add_customer_dialog(
  TextEditingController customer_name_controller,
  String customer_city,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String customer_name_hint,
  String customer_city_hint,
) {
  return Get.defaultDialog(
    title: "أضف عميلًا",
    middleText: "",
    buttonColor: AppColors.primary,
    backgroundColor: AppColors.backgroundColor,
    onConfirm: () {
      onConfirm();
      customer_name_controller.clear();
      customer_city = "";
    },
    onCancel: () {},
    actions: [
      SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Custom_textfield(
              hintText: customer_name_hint,
              suffixIcon: Icons.person,
              validator: (p0) {
                return validatorInput(p0!, 3, 100, "name");
              },
              controller: customer_name_controller,
              onChanged: (p0) {},
            ),

            Custom_dropDownButton(
              value: "customer_city",
              onChanged: (value) => onChangedCity(value),
              hint: customer_city_hint,
              items: city_data,
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    ],
  );
}
