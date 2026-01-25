import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> customEditBrandsTypeDialog(
  void Function() onConfirm,
  TextEditingController buyingController,
  TextEditingController salesController,
  TextEditingController sizeController,
  String currentBuyingPrice,
  String currentSalesPrice,
  String currentSize,
  GlobalKey<FormState> formKey,
) {
  // Set the current values in the controllers
  buyingController.text = currentBuyingPrice;
  salesController.text = currentSalesPrice;
  sizeController.text = currentSize;

  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(5),
    title: "تعديل تفاصيل المنتج",
    middleText: "",
    actions: [
      Form(
        key: formKey,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 15,
            children: [
              Custom_textfield(
                hintText: 'سعر الشراء',
                suffixIcon: Icons.attach_money,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال سعر الشراء';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
                controller: buyingController,
                onChanged: (String value) {},
              ),
              Custom_textfield(
                hintText: 'سعر البيع',
                suffixIcon: Icons.sell,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال سعر البيع';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
                controller: salesController,
                onChanged: (String value) {},
              ),
              Custom_textfield(
                hintText: 'حجم المنتج',
                suffixIcon: Icons.straighten,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال حجم المنتج';
                  }
                  return null;
                },
                controller: sizeController,
                onChanged: (String value) {},
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ],
    backgroundColor: AppColors.backgroundColor,
    buttonColor: AppColors.primary,
    textConfirm: "تعديل",
    textCancel: "إلغاء",
    onConfirm: () {
      if (formKey.currentState!.validate()) {
        onConfirm();
      }
    },
    onCancel: () {
      Get.back();
    },
  );
}
