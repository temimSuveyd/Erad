

import 'package:erad/controller/suppliers/bills/suppliers_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/csutom_lable_details.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/custom_bill_details_heder.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/custom_prodects_details_sliverListBuilder.dart';
import 'package:erad/view/supplier/bills/supplier_bill_details/widgets/custom_text_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/custom_add_button.dart';

class SupplierBillDetailsPage extends GetView<SuppliersBillDetailsControllerImp> {
  const SupplierBillDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuppliersBillDetailsControllerImp());
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
                    onPressed: () => controller.discountOnSupplierBill(),
                  ),
                  Custom_button( color: AppColors.primary,
                    icon: Icons.print,
                    title: 'طباعة (PDF)',
                    onPressed: () => controller.createSupplierBillPdf(),
                  ),
                  Custom_button( color: AppColors.primary,
                    icon: Icons.delete,
                    title: "حذف",
                    onPressed: () => controller.showDeleteSupplierBillDialog(),
                  ),
                       Custom_button( color: AppColors.primary,
                    icon: Icons.payments_outlined,
                    title: "تغيير طريقة الدفع",
                    onPressed: () => controller.showEditSupplierPaymentTypeDialog(),
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
