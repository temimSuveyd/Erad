import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:erad/core/class/handling_data_view_with_sliverBox.dart';
import 'package:erad/core/constans/design_tokens.dart';
import 'package:erad/data/model/suppliers/suppliers_model.dart';
import 'package:flutter/widgets.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_Card.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/mobile_supplier_card.dart';
import 'package:get/get.dart';

class CustomSuppliersListView extends StatelessWidget {
  const CustomSuppliersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = DesignTokens.isMobile(context);

    return GetBuilder<SuppliersControllerImp>(
      builder:
          (controller) => HandlingDataViewWithSliverBox(
            onPressed: () => controller.getSuppliers(),
            statusreqest: controller.statusreqest,
            widget: SliverList.builder(
              itemCount: controller.suppliersList.length,
              itemBuilder: (context, index) {
                final supplierModel = SuppliersModel.formatJson(
                  controller.suppliersList[index],
                );

                // Use mobile card for mobile screens, desktop card for larger screens
                return isMobile
                    ? MobileSupplierCard(supplierModel: supplierModel)
                    : Custom_suppliers_Card(suppliersModel: supplierModel);
              },
            ),
          ),
    );
  }
}
