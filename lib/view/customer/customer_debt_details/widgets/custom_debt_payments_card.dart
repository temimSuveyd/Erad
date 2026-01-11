import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/data/model/customer_depts/customer_dept_payments_model.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_date_text_container.dart';
import 'package:erad/view/custom_widgets/custom_price_text_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custom_debt_payments_card
    extends GetView<CustomerDeptsDetailsControllerImp> {
  const Custom_debt_payments_card({super.key, required this.deptPaymentsModel});
  final DeptPaymentsModel deptPaymentsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Custom_date_text_container(
            title:
                "${deptPaymentsModel.paymentDate!.year}/${deptPaymentsModel.paymentDate!.month.toString().padLeft(2, '0')}/${deptPaymentsModel.paymentDate!.day.toString().padLeft(2, '0')}",
            width: 130,
          ),
          Custom_price_text_container(
            price: "${deptPaymentsModel.paymentPrice}",
          ),

          CustomButton(
            icon: Icons.delete,
            title: "احذف",
            onPressed:
                () =>
                    controller.showDeletePayment(deptPaymentsModel.paymentId!),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
