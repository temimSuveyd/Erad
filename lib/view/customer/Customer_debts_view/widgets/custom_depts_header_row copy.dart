import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/data/model/customer_depts/customer_depts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';

import '../../../supplier/bills/suppliers_bills_add/widgets/custom_price_container.dart';

class Custom_depts_view_card extends GetView<CustomerDeptsViewControllerImp> {
  const Custom_depts_view_card({super.key, required this.deptModel});
  final DeptsModel deptModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsetsDirectional.all(5),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            spacing: 10,
            children: [
              Custom_price_container(
                title: deptModel.customer_name!,
                width: 200,
              ),

              Custom_price_container(
                title:
                    "${deptModel.bill_date!.year}/${deptModel.bill_date!.month}/${deptModel.bill_date!.day}",
                width: 200,
              ),
              Custom_price_container(
                title: deptModel.total_price!.toString(),
                width: 160,
              ),

              Custom_button(
                color: AppColors.primary,
                icon: Icons.open_in_new,
                title: "تفاصيل",
                onPressed: () {
                  controller.goTODetailsPage(deptModel.id!);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
