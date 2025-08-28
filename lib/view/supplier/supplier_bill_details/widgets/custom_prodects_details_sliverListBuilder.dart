

// ignore: camel_case_types
import 'package:Erad/controller/suppliers/suppliers_bill_details_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/view/supplier/supplier_bill_details/widgets/custom_prodect_details_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../data/model/customer_bill_details/bill_details_product_model.dart';

class Custom_products_details_sliverListBuilder extends StatelessWidget {
  const Custom_products_details_sliverListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuppliersBillDetailsControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.productList.length,
              itemBuilder:
                  (context, index) => Custom_product_details_card(
                    billProductsModel: BillDetailsProductsModel.formatJson(
                      controller.productList[index],
                    ),
                  ),
            ),
            onPressed: () => controller.getBillProducts(),
          ),
    );
  }
}
