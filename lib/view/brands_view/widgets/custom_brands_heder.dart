import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/brands/brands_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';

class Custom_Brands_heder extends GetView<BrandsControllerImp> {
  const Custom_Brands_heder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 320,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Text(
            "العلامة التجارية",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.wihet,
            ),
          ),
        ),
        SizedBox(width: 20),
        Custom_button( color: AppColors.primary,
          icon: Icons.add,
          onPressed: () => controller.show_dialog(),
          title: "إضافة",
        ),
      ],
    );
  }
}
