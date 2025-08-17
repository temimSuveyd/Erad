import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customer_add_bill_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_bill_add_listView.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_bill_options_container.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_label_row.dart';

class CustomerBillAddPage extends GetView<CustomerBiilAddControllerImp> {
  const CustomerBillAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerBiilAddControllerImp());
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: Custom_appBar(title: "أضف فاتورة العميل"),
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
