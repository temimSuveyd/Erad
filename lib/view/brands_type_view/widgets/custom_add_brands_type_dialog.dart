import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/core/function/validatorInpot.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_amout_dropDown_button.dart';

// ignore: non_constant_identifier_names
Future<dynamic> custom_add_brands_type_dialog(
  void Function() onConfirm,
  TextEditingController buying_controller,
  TextEditingController sales_controller,
  TextEditingController size_controller,
  String hintText_sales,
  String hintText_buying,
  String hintText_size,
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
                  hintText: hintText_buying,
                  controller: buying_controller,
                ),
                Csutom_count_textField(
                  suffixIcon: Icons.attach_money_outlined,
                  hintText: hintText_sales,
                  controller: sales_controller,
                ),
                Csutom_count_textField(
                  suffixIcon: Icons.scale_outlined,

                  hintText: hintText_size,
                  controller: size_controller,
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
    backgroundColor: AppColors.backgroundColor,
    buttonColor: AppColors.primary,
    onConfirm: () {
      onConfirm();
      buying_controller.clear();
      sales_controller.clear();
      size_controller.clear();
    },
    onCancel: () {
      buying_controller.clear();
      sales_controller.clear();
      size_controller.clear();
    },
  );
}
