

import 'package:erad/controller/suppliers/bills/suppliers_bill_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_bill_name_list.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/custom_widgets/show_date_range_picker.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_view/widgets/custom_list_view_builder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuppliersBillsViewPage extends GetView<SuppliersBillViewControllerImp> {
  const SuppliersBillsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuppliersBillViewControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "فواتير الموردين"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GetBuilder<SuppliersBillViewControllerImp>(
                builder: (controller) => 
               Row(
                  spacing: 10,
                  children: [
                Custom_textfield(
                            hintText: 'اسم العميل',
                            suffixIcon: Icons.search,
                            validator: (String? validator) {
                              return null;
                            },
                            controller: controller.searchBillsTextController,
                            onChanged: (p0) {
                              controller.searchForBillsBaySupplierName();
                            },
                          ),
                            Custom_set_date_button(
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
                   Custom_dropDownButton(
                            value: "value",
                            onChanged:
                                (value) => controller.searchForBillBayCity(value),
                            hint:
                                controller.selectedSupplierCity ?? "حدد المدينة",
                            items: city_data,
                          ),
                
                    Custom_button(
                      icon: Icons.filter_list_off_outlined,
                      title: "إزالة جميع الفلاتر",
                      onPressed: () => controller.getSuppliersBills(),
                      color: AppColors.red,
                    ),
                  ],
                ),
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
