import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customer_add_bill_controller.dart';
import 'package:Erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:Erad/data/model/customer_bill_add/prodects_model.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_add_prodect_container.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_add_product_card.dart';

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
