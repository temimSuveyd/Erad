import 'package:erad/controller/suppliers/depts/supplier_depts_view_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/view/supplier/depts/supplier_debts_view/widgets/mobile_supplier_debt_card.dart';
import 'package:erad/view/supplier/depts/supplier_debts_view/widgets/custom_depts_header_row%20copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/model/supplier_depts/supplier_depts_model.dart';

class Custom_deptsListView extends StatelessWidget {
  const Custom_deptsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierDeptsViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getDepts(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.supplierDeptsList.length,
              itemBuilder: (context, index) {
                final isMobile = DesignTokens.isMobile(context);

                if (isMobile) {
                  // Use mobile card for mobile devices
                  return MobileSupplierDebtCard(
                    deptModel: DeptsModel.formatJson(
                      controller.supplierDeptsList[index],
                    ),
                  );
                } else {
                  // Use desktop card for larger screens
                  return Row(
                    children: [
                      Custom_depts_view_card(
                        deptModel: DeptsModel.formatJson(
                          controller.supplierDeptsList[index],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
    );
  }
}
