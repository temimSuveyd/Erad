import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:suveyd_ticaret/controller/customers_controller.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_add_button.dart';

class Custom_customers_heder extends GetView<CustomersControllerImp> {
  const Custom_customers_heder({super.key});

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
          icon: Icons.add,
          onPressed: () => controller.show_add_customer_dialog(),
          title: "إضافة",
        ),
      ],
    );
  }
}
