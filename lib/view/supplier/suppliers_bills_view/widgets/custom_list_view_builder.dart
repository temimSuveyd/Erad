import 'package:Erad/controller/suppliers/suppliers_bill_view_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/data/model/supplier_bill_view/bill_model.dart';
import 'package:Erad/view/supplier/suppliers_bills_view/widgets/custom_bill_header_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Custom_listviewBuilder extends StatelessWidget {
  const Custom_listviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuppliersBillViewControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getSuppliersBills(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.supplier_bills_list.length,
              itemBuilder:
                  (context, index) => Custom_bill_view_card(
                    billModel: BillModel.formatJson(
                      controller.supplier_bills_list[index],
                    ),
                  ),
            ),
          ),
    );
  }
}
