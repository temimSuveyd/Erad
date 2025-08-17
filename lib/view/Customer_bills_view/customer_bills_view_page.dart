import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customer_bill_view_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/data_score/static/city_data.dart';
import 'package:Erad/view/Customer_bills_view/widgets/custom_list_view_builder.dart';
import 'package:Erad/view/Customer_bills_view/widgets/custom_name_list.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';
import 'package:Erad/view/custom_widgets/custom__dropDownButton.dart';
import 'package:Erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:Erad/view/custom_widgets/show_date_range_picker.dart';

class CustomerBillsViewPage extends GetView<CustomerBillViewControllerImp> {
  const CustomerBillsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerBillViewControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "فواتير العملاء"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 10,
                children: [
                  GetBuilder<CustomerBillViewControllerImp>(
                    builder:
                        (controller) => Custom_textfield(
                          hintText: 'اسم العميل',
                          suffixIcon: Icons.search,
                          validator: (String? validator) {},
                          controller: controller.searchBillsTextController,
                          onChanged: (p0) {
                            controller.searchForBillsBayCustomerName();
                          },
                        ),
                  ),
                  GetBuilder<CustomerBillViewControllerImp>(
                    builder:
                        (controller) => Custom_set_date_button(
                          hintText:
                              controller.selectedEndDate == null
                                  ? "حدد تاريخ الفواتير"
                                  : "${controller.selectedStartDate} - ${controller.selectedEndDate}",
                          onPressed: () {
                            show_date_range_picker(context).then((dateRange) {
                              controller.searchByDate(
                                dateRange!.start,
                                dateRange.end,
                              );
                            });
                          },
                        ),
                  ),
                  GetBuilder<CustomerBillViewControllerImp>(
                    builder:
                        (controller) => Custom_dropDownButton(
                          value: "value",
                          onChanged:
                              (value) => controller.searchForBillBayCity(value),
                          hint:
                              controller.selectedCustomerCity ?? "حدد المدينة",
                          items: city_data,
                        ),
                  ),

                  Custom_button(
                    icon: Icons.filter_list_off_outlined,
                    title: "إزالة جميع الفلاتر",
                    onPressed: () => controller.getCustomersBills(),
                    color: AppColors.red,
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),
            CustomerNameList(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            Custom_listviewBuilder(),
          ],
        ),
      ),
    );
  }
}
