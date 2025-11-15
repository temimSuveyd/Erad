import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/suppliers/bills/suppliers_bill_details_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/customer/customer_bill_details/widgets/custom_biil_details_text_container.dart';

// ignore: camel_case_types
class Custom_bill_details_heder extends StatelessWidget {
  const Custom_bill_details_heder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.grey,
                ),
                child: GetBuilder<SuppliersBillDetailsControllerImp>(
                  builder: (controller) => Row(
                    spacing: 10,
                    children: [
                      Custom_biil_details_text_container(
                        title_1: controller.supplierBillModel?.supplier_name ?? "قيمة فارغة",
                        title_2: "اسم المورد",
                        color: AppColors.black,
                      ),
                      Custom_biil_details_text_container(
                        title_1: controller.supplierBillModel?.supplier_city ?? "قيمة فارغة",
                        title_2: 'مدينة',
                        color: AppColors.black,
                      ),
                      Custom_biil_details_text_container(
                        title_1: controller.supplierBillModel?.bill_no ?? "قيمة فارغة",
                        title_2: "رقم الفاتورة",
                        color: AppColors.black,
                      ),
                      Custom_biil_details_text_container(
                        title_1: (() {
                          final billDate = controller.supplierBillModel?.bill_date;
                          if (billDate == null) return "قيمة فارغة";
                          final date = DateTime.tryParse(
                            billDate.toString(),
                          );
                          if (date != null) {
                            return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                          } else {
                            return billDate.toString();
                          }
                        })(),
                        title_2: "تاريخ الفاتورة",
                        color: AppColors.black,
                      ),
                      Custom_biil_details_text_container(
                        title_1: controller.supplierBillModel?.payment_type == null
                            ? "قيمة فارغة"
                            : controller.supplierBillModel!.payment_type == "monetary"
                                ? "نقدي"
                                : "دَين",
                        title_2: "طريقة الدفع",
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.grey,
                ),
                child: GetBuilder<SuppliersBillDetailsControllerImp>(
                  builder: (controller) => Row(
                    spacing: 10,
                    children: [
                      Custom_biil_details_text_container(
                        title_1: controller.total_price?.toString() ?? "قيمة فارغة",
                        title_2: "المبلغ الإجمالي",
                        color: controller.total_price == null
                            ? AppColors.red
                            : controller.total_price! < 0
                                ? AppColors.red
                                : AppColors.green,
                      ),
                      Custom_biil_details_text_container(
                        title_1: controller.total_earn?.toString() ?? "قيمة فارغة",
                        title_2: "إجمالي الأرباح",
                        color: controller.total_price == null
                            ? AppColors.red
                            : controller.total_price! < 0
                                ? AppColors.red
                                : AppColors.green,
                      ),
                      Custom_biil_details_text_container(
                        title_1: controller.discount_amount.toString(),
                        title_2: "خصم من الفاتورة",
                        color: controller.discount_amount == 0.0
                            ? AppColors.red
                            : AppColors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
