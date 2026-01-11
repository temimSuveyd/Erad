import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/core/constans/routes.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_name_label.dart';

class CustomerDeptNameList extends StatelessWidget {
  const CustomerDeptNameList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    if (isDesktop) {
      return SliverToBoxAdapter(
        child: Row(
          spacing: 3,
          children: [
            CustomerNameLabel(title: "اسم المورد", width: 220),
            CustomerNameLabel(title: "تاريخ", width: 200),
            CustomerNameLabel(title: "إجمالي الدَين", width: 160),
            SizedBox(width: 10),
            CustomButton(
              color: AppColors.primary,
              icon: Icons.add,
              onPressed: () {
                Get.toNamed(AppRoutes.supplier_bills_add_page);
              },
              title: "إضافة",
            ),
          ],
        ),
      );
    }

    // Mobile layout
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomerNameLabel(title: "اسم المورد", width: 0),
              ),
              SizedBox(width: 3),
              Expanded(
                flex: 2,
                child: CustomerNameLabel(title: "تاريخ", width: 0),
              ),
              SizedBox(width: 3),
              Expanded(
                flex: 2,
                child: CustomerNameLabel(title: "الدَين", width: 0),
              ),
            ],
          ),
          SizedBox(height: 8),
          CustomButton(
            color: AppColors.primary,
            icon: Icons.add,
            onPressed: () {
              Get.toNamed(AppRoutes.supplier_bills_add_page);
            },
            title: "إضافة",
          ),
        ],
      ),
    );
  }
}
