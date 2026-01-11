import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:get/state_manager.dart';

class CustomSuppliersHeader extends GetView<SuppliersControllerImp> {
  const CustomSuppliersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    if (isDesktop) {
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
          CustomButton(
            color: AppColors.primary,
            icon: Icons.add,
            onPressed: () => controller.show_add_Suppliers_dialog(),
            title: "إضافة",
          ),
        ],
      );
    }

    // Mobile layout
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(color: AppColors.primary),
                child: Text(
                  "اسم",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.wihet,
                  ),
                ),
              ),
            ),
            SizedBox(width: 3),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(color: AppColors.primary),
                child: Text(
                  "مدينة",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.wihet,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        CustomButton(
          color: AppColors.primary,
          icon: Icons.add,
          onPressed: () => controller.show_add_Suppliers_dialog(),
          title: "إضافة",
        ),
      ],
    );
  }
}
