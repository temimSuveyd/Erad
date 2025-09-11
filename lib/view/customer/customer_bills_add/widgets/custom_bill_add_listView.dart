import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/customer_bill_add/prodects_model.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/custom_add_prodect_container.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/custom_add_product_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Custom_bill_add_listView extends StatelessWidget {
  const Custom_bill_add_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBiilAddControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount:
                  controller.bill_prodects_list.length == 1
                      ? 2
                      : controller.bill_prodects_list.length + 1,

              itemBuilder:
                  (context, index) =>
                      index == controller.bill_prodects_list.length
                          ? Custom_add_product_card()
                          : Custom_add_product_container(
                            onPressed: () => controller.deleteProduct(index),
                            billProductsModel: BillProductsModel.formaToJson(
                              controller.bill_prodects_list[index],
                            ),
                          ),
            ),
            onPressed: () => controller.getBillProdects(),
          ),
    );
  }
}
