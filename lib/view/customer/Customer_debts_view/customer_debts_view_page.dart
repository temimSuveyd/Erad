import 'package:erad/controller/customers/depts/customer_depts_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/custom_dept_name_list.dart';
import 'package:erad/view/customer/Customer_debts_view/widgets/custom_list_view_builder.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/show_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:get/get.dart';

class CustomerDebtsViewPage extends GetView<CustomerDeptsViewControllerImp> {
  CustomerDebtsViewPage({super.key});
  final List<String> titleList = ["محمود ديبا", "مدينة", " 150", "300", "290"];
  final List<double> width = [300, 200, 200, 200, 200];
  @override
  Widget build(BuildContext context) {
    Get.put(CustomerDeptsViewControllerImp());

    return Scaffold(
      appBar: Custom_appBar(title: "ديون العملاء"),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 20, // Horizontal space between children
                // runSpacing: 20, // Vertical space between lines
                children: [
                  Custom_textfield(
                    hintText: 'اسم العميل',
                    suffixIcon: Icons.add,
                    validator: (p0) {
                      return null;
                    },
                    controller: controller.searchDeptsTextController,
                    onChanged:
                        (value) => controller.searchForBillsBayCustomerName(),
                  ),

                  Custom_dropDownButton(
                    value:
                        controller
                            .selectedCustomerCity, // Use the controller's selected value
                    onChanged:
                        (value) => controller.searchForBillBayCity(value),
                    hint: 'اختر المدينة',
                    items: city_data,
                  ),
                  Custom_button(
                    icon: Icons.filter_list_off_outlined,
                    title: "إزالة جميع الفلاتر",
                    onPressed: () => controller.getDepts(),
                    color: AppColors.red,
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),
            CustomerDeptNameList(),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            Custom_deptsListView(),
          ],
        ),
      ),
    );
  }
}
