import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/customer_bill_details/bill_details_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/bills/customer_bill_details_controller.dart';
import 'package:erad/view/customer/customer_bill_details/widgets/custom_prodect_details_card.dart';

// ignore: camel_case_types
class Custom_products_details_sliverListBuilder extends StatelessWidget {
  const Custom_products_details_sliverListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBillDetailsControllerImp>(
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
