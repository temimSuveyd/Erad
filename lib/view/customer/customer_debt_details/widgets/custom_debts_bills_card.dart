import 'package:Erad/controller/customers/customer_dept_details_controller.dart';
import 'package:Erad/data/model/customer_depts/customer_dept_bills_model.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_date_text_container.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Custom_debts_bills_card
    extends GetView<CustomerDeptsDetailsControllerImp> {
  final DeptBillsModel deptsBillsModel;
  Custom_debts_bills_card({super.key, required this.deptsBillsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(bottom: 5),
      height: 50,
      width: 740,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Custom_date_text_container(title: deptsBillsModel.billNo!, width: 200,),
          Custom_date_text_container(
            width: 130,
            title:
                "${deptsBillsModel.billDate!.year}/${deptsBillsModel.billDate!.month}/${deptsBillsModel.billDate!.day}",
          ),
          Custom_date_text_container(
            width: 200,
            title: deptsBillsModel.totalPrice.toString(),
          ),
// Spacer(),
          Custom_button(
            icon: Icons.open_in_browser_rounded,
            title: "عرض الفاتورة",
            onPressed:
                () => controller.goToBillDetails(deptsBillsModel.billId!),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
