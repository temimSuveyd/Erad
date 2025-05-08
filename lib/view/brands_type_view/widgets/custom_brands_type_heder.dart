import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:suveyd_ticaret/controller/brands_type_controller.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_add_button.dart';

class Custom_brands_type_heder extends GetView<BrandsTypeControllerImp> {
  const Custom_brands_type_heder({super.key});

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
            "نوع المنتج",
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
          width: 270,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Text(
            "حجم المنتج",
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
            "سعر الشراء",
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
          width: 190,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Text(
            "سعر البيع",
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
            "أرباح هذا المنتج",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.wihet,
            ),
          ),
        ),
        SizedBox(width: 20),
        Custom_button(
          icon: Icons.add,
          onPressed: () => controller.show_dialog(),
          title: "إضافة",
        ),
      ],
    );
  }
}
