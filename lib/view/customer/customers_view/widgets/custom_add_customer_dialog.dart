import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/function/validatorInpot.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> Custom_add_customer_dialog(
  TextEditingController customerNameController,
  String customerCity,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String customerNameHint,
  String customerCityHint,
) {
  return Get.defaultDialog(
    title: "أضف عميلًا",
    titleStyle: const TextStyle(color: AppColors.grey),
    middleText: "",
    buttonColor: AppColors.primary,
    backgroundColor: AppColors.backgroundColor,
    onConfirm: () {
      onConfirm();
      customerNameController.clear();
      customerCity = "";
    },
    onCancel: () {},
    actions: [
      SizedBox(
        width: double.infinity ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Custom_textfield(
              hintText: customerNameHint,
              suffixIcon: Icons.person,
              validator: (p0) {
             
              },
              controller: customerNameController,
              onChanged: (p0) {},
            ),

            Custom_dropDownButton(
              value: "customer_city",
              onChanged: (value) => onChangedCity(value),
              hint: customerCityHint,
              items: city_data,
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    ],
  );
}
