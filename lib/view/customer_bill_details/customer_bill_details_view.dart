import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customer_bill_details_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/customer_bill_details/widgets/csutom_lable_details.dart';
import 'package:Erad/view/customer_bill_details/widgets/custom_bill_details_heder.dart';
import 'package:Erad/view/customer_bill_details/widgets/custom_prodects_details_sliverListBuilder.dart';
import 'package:Erad/view/customer_bill_details/widgets/custom_text_body.dart';

class CustomerBillDetailsPage extends GetView<CustomerBillDetailsControllerImp> {
  const CustomerBillDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerBillDetailsControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "تفاصيل الفاتورة"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            Custom_text_body(title: "معلومات الفواتير"),
            Custom_bill_details_heder(),
            Custom_text_body(title: "البضائع"),
            Csutom_lable_details(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            Custom_products_details_sliverListBuilder(),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: Row(
                spacing: 20,
                children: [
                  Custom_button( color: AppColors.primary,
                    icon: Icons.discount,
                    title: 'خصم على الفاتورة',
                    onPressed: () => controller.discount_on_bill(),
                  ),
                  Custom_button( color: AppColors.primary,
                    icon: Icons.print,
                    title: 'طباعة (PDF)',
                    onPressed: () => controller.createPdf(),
                  ),
                  Custom_button( color: AppColors.primary,
                    icon: Icons.delete,
                    title: "حذف",
                    onPressed: () => controller.show_delete_bill_dialog(),
                  ),
                       Custom_button( color: AppColors.primary,
                    icon: Icons.payments_outlined,
                    title: "تغيير طريقة الدفع",
                    onPressed: () => controller.showEditPaymentTypeDailog(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
