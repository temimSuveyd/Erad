import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/customer_depts/customer_depts_model.dart';
import 'package:erad/data/model/customer_debts_view/customer_debts_model.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/custom_depts_header_row%20copy.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/mobile_customer_debt_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDeptsListView extends StatelessWidget {
  const CustomDeptsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    return GetBuilder<CustomerDeptsViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getDepts(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.customersDeptsList.length,
              itemBuilder: (context, index) {
                final deptModel = DeptsModel.formatJson(
                  controller.customersDeptsList[index],
                );

                if (isMobile) {
                  // Convert DeptsModel to CustomerDebtsModel for mobile card
                  final debtModel = CustomerDebtsModel(
                    bill_id: deptModel.id,
                    customer_name: deptModel.customer_name,
                    customer_city: deptModel.customer_city,
                    dept_amount: deptModel.total_price,
                    bill_date: deptModel.bill_date,
                  );
                  return MobileCustomerDebtCard(debtModel: debtModel);
                } else {
                  return Row(
                    children: [Custom_depts_view_card(deptModel: deptModel)],
                  );
                }
              },
            ),
          ),
    );
  }
}
