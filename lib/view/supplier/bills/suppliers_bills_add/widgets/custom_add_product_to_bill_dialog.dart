  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';

Future<dynamic> custom_add_product_to_bill_dialog(TextEditingController controller,List<DropdownMenuItem<String>>? items,dynamic Function(String) onProductChange,void Function() onConfirm,

String dropdownHint,String textfieldHint) {
    return Get.defaultDialog(
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.background,
      onCancel: () {
        controller.clear();
        
      },
      onConfirm: () {
        onConfirm();
        Get.close(0);
        controller.clear();

      },
    title: "أضف المنتج",
    middleText: "",
    actions: [
      SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomDropDownButton(
              items: items,
              onChanged: (value) => onProductChange(value),
              hint: dropdownHint,
              value: "",
            ),
            CustomTextField(
              hintText: textfieldHint,
              suffixIcon: Icons.add_box_rounded,
              validator: (p0) {
                return null;
              },
              controller: controller,
              onChanged: (p0) {},
            ),
          ],
        ),
      ),
    ],
  );
  }
