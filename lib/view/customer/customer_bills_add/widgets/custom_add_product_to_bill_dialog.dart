  import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom__dropDownButton.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';

Future<dynamic> custom_add_product_to_bill_dialog(TextEditingController controller,List<DropdownMenuItem<String>>? items,dynamic Function(String) onProductChange,void Function() onConfirm,

String dropDown_hint,String textfield_hint) {
    return Get.defaultDialog(
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.backgroundColor,
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
            Custom_dropDownButton(
              items: items,
              onChanged: (value) => onProductChange(value),
              hint: dropDown_hint,
              value: "",
            ),
            Custom_textfield(
              hintText: textfield_hint,
              suffixIcon: Icons.add_box_rounded,
              validator: (p0) {},
              controller: controller,
              onChanged: (p0) {},
            ),
          ],
        ),
      ),
    ],
  );
  }