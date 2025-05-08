import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/core/constans/routes.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_add_button.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_name_label.dart';

class CustomerNameList extends StatelessWidget {
  const CustomerNameList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        spacing: 3,
        children: [
          CustomerNameLabel(title: "اسم العميل", widgets: 315),
          CustomerNameLabel(title: "مدينة", widgets: 280),
          CustomerNameLabel(title: "تاريخ", widgets: 220),
          CustomerNameLabel(title: "إجمالي السعر", widgets: 230),
          CustomerNameLabel(title: "نوع الفاتورة", widgets: 220),

          SizedBox(width: 10),

          Custom_button(icon: Icons.add, onPressed: () {Get.toNamed(AppRoutes.customer_bills_add_page);}, title: "إضافة"),
        ],
      ),
    );
  }
}
