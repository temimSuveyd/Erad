import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_view_controller.dart';
import 'package:erad/data/model/customer_bills_view/bill_model.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_bill_header_row.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/mobile_bill_card.dart';

class CustomListViewBuilder extends StatelessWidget {
  const CustomListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    return GetBuilder<CustomerBillViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getCustomersBills(),
            statusreqest: controller.statusreqest,
            message: "لا توجد فاتورة لهذا تاريخ",
            widget: SliverList.builder(
              itemCount: controller.customerBillsList.length,
              itemBuilder: (context, index) {
                final billModel = BillModel.formatJson(
                  controller.customerBillsList[index],
                );

                // Use mobile card for mobile screens, desktop card for larger screens
                return isMobile
                    ? MobileBillCard(billModel: billModel)
                    : Custom_bill_view_card(billModel: billModel);
              },
            ),
          ),
    );
  }
}
