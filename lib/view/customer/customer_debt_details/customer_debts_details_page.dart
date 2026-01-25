import 'package:erad/controller/customers/depts/customer_dept_details_controller.dart';
import 'package:erad/core/class/handling_data_view.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/custom_date_text_container.dart';
import 'package:erad/view/custom_widgets/show_date_range_picker.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/custom_depts_details_heder.dart';
import 'package:flutter/material.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/custom_debt_payment_type_heder.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/custom_debt_payments_listView.dart';
import 'package:erad/view/customer/customer_debt_details/widgets/custom_debts_bills_listView.dart';
import 'package:get/get.dart';

class CustomerDebtsDetailsPage
    extends GetView<CustomerDeptsDetailsControllerImp> {
  const CustomerDebtsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerDeptsDetailsControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "تفاصيل الديون"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          Row(
            children: [
              GetBuilder<CustomerDeptsDetailsControllerImp>(
                builder:
                    (controller) => Custom_set_date_button(
                      hintText:
                          controller.selectedDateRange == null
                              ? "${controller.startedDateRange?.start.year}/${controller.startedDateRange?.start.month}/${controller.startedDateRange?.start.day} - ${controller.startedDateRange?.end.year}/${controller.startedDateRange?.end.month}/${controller.startedDateRange?.end.day}"
                              : "${controller.selectedDateRange!.start.year}/${controller.selectedDateRange!.start.month}/${controller.selectedDateRange!.start.day} - ${controller.selectedDateRange!.end.year}/${controller.selectedDateRange!.end.month}/${controller.selectedDateRange!.end.day}",
                      onPressed: () {
                        show_date_range_picker(context).then((dateRange) {
                          if (dateRange != null) {
                            controller.setDateRenage(dateRange);
                          }
                        });
                      },
                    ),
              ),
            ],
          ),
          SizedBox(height: 20),

          Row(children: [Custom_depts_details_heder()]),
          SizedBox(height: 50),

          GetBuilder<CustomerDeptsDetailsControllerImp>(
            builder:
                (controller) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Custom_debt_payment_type_heder(
                          titles_list: [
                            Custom_date_text_container(
                              title: "رقم الفاتورة",
                              width: 200,
                            ),
                            Custom_date_text_container(
                              title: "تاريخ الفاتورة",
                              width: 135,
                            ),
                            Custom_date_text_container(
                              title: "إجمالي السعر",
                              width: 200,
                            ),
                          ],
                          width: Get.width / 2 * 1.080,
                        ),
                        Custom_debts_bills_listView(),
                      ],
                    ),
                    Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Custom_debt_payment_type_heder(
                              titles_list: [
                                Custom_date_text_container(
                                  title: "تاريخ الدفعة",
                                  width: 130,
                                ),
                                Custom_date_text_container(
                                  title: "إجمالي مبلغ",
                                  width: 190,
                                ),
                              ],
                              width: Get.width / 2 - 350,
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              height: 40,
                              child: Custom_button(
                                icon: Icons.add,
                                title: "أضف دفعة",
                                onPressed:
                                    () => controller.showAddPaymentDialog(),
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Custom_debt_payments_listView(),
                      ],
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
