import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/data/model/suppliers/suppliers_model.dart';
import 'package:flutter/widgets.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_Card.dart';
import 'package:get/get.dart';

class Custom_suppliers_listView extends StatelessWidget {
  const Custom_suppliers_listView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuppliersControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getSuppliers(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.suppliersList.length,
              itemBuilder:
                  (context, index) => Custom_suppliers_Card(
                    suppliersModel: SuppliersModel.formatJson(
                      controller.suppliersList[index],
                    ),
                  ),
            ),
          ),
    );
  }
}
