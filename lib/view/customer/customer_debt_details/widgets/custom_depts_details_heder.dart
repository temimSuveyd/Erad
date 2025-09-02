import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/customer/customer_bill_details/widgets/custom_biil_details_text_container.dart';

// ignore: camel_case_types
class Custom_depts_details_heder extends StatelessWidget {
  const Custom_depts_details_heder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,

          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.grey,
          ),

          child: GetBuilder<CustomerDeptsDetailsControllerImp>(
            builder:
                (controller) => Row(
                  spacing: 10,
                  children: [
                    Custom_biil_details_text_container(
                      title_1:
                          controller.deptModel?.customer_name ?? "قيمة فارغة",
                      title_2: "اسم",
                      color: AppColors.black,
                    ),

                    Custom_biil_details_text_container(
                      title_1:
                          controller.deptModel?.customer_city ?? "قيمة فارغة",
                      title_2: "مدينة",
                      color: AppColors.black,
                    ),
                    GetBuilder<CustomerDeptsDetailsControllerImp>(
                      builder:
                          (controller) => Custom_biil_details_text_container(
                            title_1: controller.remainingDebtAamount.toString(),
                            title_2: "إجمالي الدين المتبقي",
                            color: AppColors.red,
                          ),
                    ),

                    Custom_button(
                      icon: Icons.delete,
                      title: "حذف",
                      onPressed:() =>  controller.showDeleteDeptDialog(),
                      color: AppColors.primary,
                    ),
                  ],
                ),
          ),
        ),
      ],
    );
  }
}
