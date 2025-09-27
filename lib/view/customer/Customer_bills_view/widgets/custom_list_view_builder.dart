import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_view_controller.dart';
import 'package:erad/data/model/customer_bills_view/bill_model.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_bill_header_row.dart';

class Custom_listviewBuilder extends StatelessWidget {
  const Custom_listviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBillViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getCustomersBills(),
            statusreqest: controller.statusreqest,
            message: "لا توجد فاتورة لهذا تاريخ",
            widget: SliverList.builder(
              itemCount: controller.customer_bills_list.length,
              itemBuilder:
                  (context, index) => Custom_bill_view_card(
                    billModel: BillModel.formatJson(
                      controller.customer_bills_list[index],
                    ),
                  ),
            ),
          ),
    );
  }
}
