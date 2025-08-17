import 'package:Erad/controller/customers/customer_depts_view_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/data_score/static/city_data.dart';
import 'package:Erad/view/Customer_debts_view/widgets/custom_list_view_builder.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/custom_widgets/show_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:Erad/view/Customer_bills_view/widgets/custom_name_list.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';
import 'package:Erad/view/custom_widgets/custom__dropDownButton.dart';
import 'package:Erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:get/get.dart';

class CustomerDebtsViewPage extends GetView<CustomerDeptsViewControllerImp> {
  CustomerDebtsViewPage({super.key});
  final List<String> titleList = ["محمود ديبا", "مدينة", " 150", "300", "290"];
  final List<double> width = [300, 200, 200, 200, 200];
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomerDeptsViewControllerImp());

    return Scaffold(
      appBar: Custom_appBar(title: "ديون العملاء"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Wrap(
                spacing: 20, // Horizontal space between children
                runSpacing: 20, // Vertical space between lines
                children: [
                  Custom_textfield(
                    hintText: 'اسم او رقم الفاتورة',
                    suffixIcon: Icons.add,
                    validator: (p0) {
                      return null;
                    },
                    controller: controller.searchDeptsTextController,
                    onChanged:
                        (value) => controller.searchForBillsBayCustomerName(),
                  ),
                  GetBuilder<CustomerDeptsViewControllerImp>(
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
                  Custom_dropDownButton(
                    value: controller.selectedCustomerCity, // Use the controller's selected value
                    onChanged:
                        (value) => controller.searchForBillBayCity(value),
                    hint: 'اختر المدينة',
                    items: city_data,
                  ),
             Custom_button(
                    icon: Icons.filter_list_off_outlined,
                    title: "إزالة جميع الفلاتر",
                    onPressed: () => controller.getBills(),
                    color: AppColors.red,
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),
            CustomerNameList(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            Custom_deptsListView(),
          ],
        ),
      ),
    );
  }
}
