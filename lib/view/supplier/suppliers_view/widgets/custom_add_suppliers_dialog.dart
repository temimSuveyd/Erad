import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/function/validatorInpot.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> Custom_add_suppliers_dialog(
  TextEditingController supplierNameController,
  String supplierCity,
  void Function() onConfirm,
  dynamic Function(String) onChangedCity,
  String supplierNameHint,
  String supplierCityHint,
) {
  return Get.defaultDialog(
    title: "أضف المورد",
    middleText: "",
    buttonColor: AppColors.primary,
    backgroundColor: AppColors.backgroundColor,
    onConfirm: () {
      onConfirm();
      supplierNameController.clear();
      supplierCity = "";
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
              hintText: supplierNameHint,
              suffixIcon: Icons.person,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return "من فضلك أدخل اسم المورد";
                }
              },
              controller: supplierNameController,
              onChanged: (p0) {},
            ),

            Custom_dropDownButton(
              value: "supplier_city",
              onChanged: (value) => onChangedCity(value),
              hint: supplierCityHint,
              items: city_data,
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    ],
  );
}
