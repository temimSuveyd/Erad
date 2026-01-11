import 'package:erad/controller/suppliers/bills/suppliers_bill_view_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/supplier_bill_view/bill_model.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_view/widgets/custom_bill_header_row.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_view/widgets/mobile_supplier_bill_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSupplierListViewBuilder extends StatelessWidget {
  const CustomSupplierListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    return GetBuilder<SuppliersBillViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getSuppliersBills(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.supplier_bills_list.length,
              itemBuilder: (context, index) {
                final billModel = BillModel.formatJson(
                  controller.supplier_bills_list[index],
                );

                // Use mobile card for mobile screens, desktop card for larger screens
                return isMobile
                    ? MobileSupplierBillCard(billModel: billModel)
                    : Custom_bill_view_card(billModel: billModel);
              },
            ),
          ),
    );
  }
}
