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
    return SliverToBoxAdapter(
      child: Row(
        spacing: 3,
        children: [
          CustomerNameLabel(title: "اسم العميل", width: 220),
          CustomerNameLabel(title: "تاريخ", width: 200),
          CustomerNameLabel(title: "إجمالي الدَين", width: 160),

          SizedBox(width: 10),

          Custom_button(
            color: AppColors.primary,
            icon: Icons.add,
            onPressed: () {
              Get.toNamed(AppRoutes.customer_bills_add_page);
            },
            title: "إضافة",
          ),
        ],
      ),
    );
  }
}
