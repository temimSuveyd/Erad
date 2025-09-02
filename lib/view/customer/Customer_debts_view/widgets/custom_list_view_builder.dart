import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/customer_depts/customer_depts_model.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/custom_depts_header_row%20copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custom_deptsListView extends StatelessWidget {
  const Custom_deptsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDeptsViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getDepts(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.customersDeptsList.length,
              itemBuilder:
                  (context, index) => Row(
                    children: [
                      Custom_depts_view_card(
                        deptModel: DeptsModel.formatJson(
                          controller.customersDeptsList[index],
                        ),
                      ),
                    ],
                  ),
            ),
          ),
    );
  }
}
