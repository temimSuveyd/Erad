import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/categoreys/categorey_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';

class Custom_categorey_heder extends GetView<CategoreyControllerImp> {
  const Custom_categorey_heder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 320,
          color: AppColors.primary,
          child: Text(
            "اسم الفئة",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.wihet,
            ),
          ),
        ),
        CustomButton( color: AppColors.primary,
          icon: Icons.add,
          title: "يضيف",
          onPressed: () => controller.show_dialog(),
        ),
      ],
    );
  }
}
