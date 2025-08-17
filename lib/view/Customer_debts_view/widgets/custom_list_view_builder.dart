import 'package:Erad/controller/customers/customer_depts_view_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/data/model/customer_bills_view/bill_model.dart';
import 'package:Erad/view/Customer_debts_view/widgets/custom_depts_header_row%20copy.dart';
import 'package:flutter/material.dart';
import 'package:Erad/view/Customer_bills_view/widgets/custom_bill_header_row.dart';
import 'package:get/get.dart';

class Custom_deptsListView extends StatelessWidget {
  const Custom_deptsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getBills(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.customerBillsList.length,
              itemBuilder:
                  (context, index) => Row(
                    children: [
                      Custom_depts_view_card(
                        billModel: BillModel.formatJson(
                          controller.customerBillsList[index],
                        ),
                      ),
                    ],
                  ),
            ),
          ),
    );
  }
}
