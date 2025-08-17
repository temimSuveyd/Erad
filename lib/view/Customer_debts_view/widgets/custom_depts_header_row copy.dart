
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customer_bill_view_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/model/customer_bills_view/bill_model.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_price_container.dart';

class Custom_depts_view_card extends GetView<CustomerBillViewControllerImp> {
  const Custom_depts_view_card({super.key, required this.billModel});
  final BillModel billModel;
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
                title: billModel.customer_name!,
                width: 200,
              ),
              Custom_price_container(
                title: billModel.customer_city!,
                width: 200,
              ),


              Custom_price_container(
                title: billModel.total_price!.toString(),
                width: 160,
              ),

              // Spacer(),
              // Custom_details_button(),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.open_in_new,
                title: "تفاصيل",
                onPressed: () {
                  controller.goToDetailsPage(billModel.bill_id!);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
