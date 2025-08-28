import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/core/constans/routes.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/customer/Customer_bills_view/widgets/custom_name_label.dart';

class CustomerNameList extends StatelessWidget {
  const CustomerNameList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        spacing: 2,
        children: [
          CustomerNameLabel(title: "اسم العميل", width: 210),
          CustomerNameLabel(title: "مدينة", width: 210),
          CustomerNameLabel(title: "تاريخ الفاتورة", width: 165),
          CustomerNameLabel(title: "إجمالي مبلغ", width: 170),
          CustomerNameLabel(title: "طريقة الدفع", width: 160),


          SizedBox(width: 10),

          Custom_button(
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
