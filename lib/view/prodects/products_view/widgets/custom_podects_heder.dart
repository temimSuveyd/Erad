import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';

class Custom_products_heder extends StatelessWidget {
  const Custom_products_heder({super.key});

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
            "نوع الفئة",
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
            "تاريخ الشراء",
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
          width: 130,
          decoration: BoxDecoration(color: AppColors.primary),
          child: Text(
            "كمية",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.wihet,
            ),
          ),
        ),
        SizedBox(width: 20),
        Custom_button( color: AppColors.primary,icon: Icons.add, onPressed: () {}, title: "إضافة"),
      ],
    );
  }
}
