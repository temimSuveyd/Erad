

import 'package:erad/controller/suppliers/bills/suppliers_bill_add_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/custom_bill_add_listView.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/custom_bill_options_container.dart' show CustomerBillOptionsContainer;
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/custom_label_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuppliersBillAddPage extends GetView<SupplierBiilAddControllerImp> {
  const SuppliersBillAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SupplierBiilAddControllerImp());
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: Custom_appBar(title: "إضافة فاتورة المورد"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomScrollView(
            slivers: [
              CustomerBillOptionsContainer(),
              SliverToBoxAdapter(child: SizedBox(height: 30)),
              Custom_label_row(),
              Custom_bill_add_listView(),

              SliverToBoxAdapter(child: SizedBox(height: 30)),

              SliverToBoxAdapter(
                child: Row(
                  spacing: 30,
                  children: [
                    Custom_button( color: AppColors.primary,
                      icon: Icons.save,
                      title: "حفظ الفاتورة",
                      onPressed: () => controller.saveBillData(),
                    ),
                    Custom_button( color: AppColors.primary,
                      icon: Icons.print,
                      title: "طباعة",
                      onPressed:() => controller.createPdf(),
                    ),
                    Custom_button( color: AppColors.primary,
                      icon: Icons.delete_forever,
                      title: "حذف",
                      onPressed: () => controller.showDleteBillDialog(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
