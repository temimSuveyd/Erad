import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';

import '../../../supplier/bills/suppliers_bills_add/widgets/custom_amout_dropDown_button.dart';

// ignore: non_constant_identifier_names
Future<dynamic> custom_add_brands_type_dialog(
  void Function() onConfirm,
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
  String hinttextSales,
  String hinttextBuying,
  String hinttextSize,
  Key? key,
) {
  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(5),
    title: "أضف المنتج",
    middleText: "",
    actions: [
      Form(
        key: key,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Csutom_count_textField(
                  suffixIcon: Icons.attach_money_outlined,
                  hintText: hinttextBuying,
                  controller: buyingController,
                ),
                Csutom_count_textField(
                  suffixIcon: Icons.attach_money_outlined,
                  hintText: hinttextSales,
                  controller: salesController,
                ),
                Csutom_count_textField(
                  suffixIcon: Icons.scale_outlined,

                  hintText: hinttextSize,
                  controller: sizeController,
                  // validator: (p0) {
                  // return validatorInput(p0, 1, 100, "text");
                  // },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ],
    backgroundColor: AppColors.background,
    buttonColor: AppColors.primary,
    onConfirm: () {
      onConfirm();
      buyingController.clear();
      salesController.clear();
      sizeController.clear();
    },
    onCancel: () {
      buyingController.clear();
      salesController.clear();
      sizeController.clear();
    },
  );
}
