import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/controller/customer_biil_add_controller.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_add_button.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_appBar.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_total_price_container.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_bill_add_listView.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_bill_options_container.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_label_row.dart';

class CustomerBillAddPage extends GetView<CustomerBiilAddControllerImp> {
  const CustomerBillAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerBiilAddControllerImp());
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
              SliverToBoxAdapter(child: SizedBox(height: 10)),
              Custom_label_row(),
              Custom_bill_add_listView(),
      
              SliverToBoxAdapter(child: SizedBox(height: 30)),
      
              SliverToBoxAdapter(
                child: Row(
                  spacing: 30,
                  children: [
                    GetBuilder<CustomerBiilAddControllerImp>(
                      builder:
                          (controller) => Custom_total_price_container(
                            title: controller.total_product_price.toString(),
                          ),
                    ),
                    Custom_button(
                      icon: Icons.save,
                      title: "حفظ الفاتورة",
                      onPressed: () {},
                    ),
                    Custom_button(
                      icon: Icons.print,
                      title: "طباعة",
                      onPressed: () {},
                    ),
                    Custom_button(
                      icon: Icons.delete_forever,
                      title: "حذف",
                      onPressed: () {},
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
