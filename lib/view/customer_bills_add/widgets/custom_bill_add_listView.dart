import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/controller/customer_biil_add_controller.dart';
import 'package:suveyd_ticaret/core/class/handling_data_view_with_sliverBox.dart';
import 'package:suveyd_ticaret/data/model/customer_bill_add/prodects_model.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_add_prodect_container.dart';

class Custom_bill_add_listView extends StatelessWidget {
  const Custom_bill_add_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBiilAddControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.bill_prodects_list.length,
              itemBuilder: (context, index) => Custom_add_product_container(
                billProductsModel: BillProductsModel.formatJson(controller.bill_prodects_list[index]),
              ),
            ),
            onPressed: () => controller.getBillProdects(),
          ),
    );
  }
}
