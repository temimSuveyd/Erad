import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/brands/brands_type_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';

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
          width: 240,
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
          width: 210,
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
          width: 170,
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
          width: 155,
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
          width: 160,
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
        Custom_button( color: AppColors.primary,
          icon: Icons.add,
          onPressed: () => controller.show_dialog(),
          title: "إضافة",
        ),
      ],
    );
  }
}
