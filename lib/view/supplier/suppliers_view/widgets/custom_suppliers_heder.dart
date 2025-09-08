import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:get/state_manager.dart';

class Custom_suppliers_heder extends GetView<SuppliersControllerImp> {
  const Custom_suppliers_heder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 3,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 300,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Text(
            "اسم",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.wihet,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 200,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Text(
            "مدينة",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.wihet,
            ),
          ),
        ),
        SizedBox(width: 20),
        Custom_button(
          color: AppColors.primary,
          icon: Icons.add,
          onPressed: () => controller.show_add_Suppliers_dialog(),
          title: "إضافة",
        ),
      ],
    );
  }
}
