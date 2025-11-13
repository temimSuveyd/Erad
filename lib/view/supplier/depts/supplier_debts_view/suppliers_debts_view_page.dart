import 'package:erad/controller/suppliers/depts/supplier_depts_view_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/custom_widgets/custom_set_date_button.dart';
import 'package:erad/view/custom_widgets/show_date_range_picker.dart';
import 'package:erad/view/supplier/depts/supplier_debts_view/widgets/custom_dept_name_list.dart';
import 'package:erad/view/supplier/depts/supplier_debts_view/widgets/custom_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierDebtsViewPage extends GetView<SupplierDeptsViewControllerImp> {
  const SupplierDebtsViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SupplierDeptsViewControllerImp());

    return Scaffold(
      appBar: Custom_appBar(title: "ديون الموردين"),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 20,

                children: [
                  Custom_textfield(
                    hintText: 'اسم او رقم الفاتورة',
                    suffixIcon: Icons.add,
                    validator: (p0) {
                      return null;
                    },
                    controller: controller.searchDeptsTextController,
                    onChanged:
                        (value) => controller.searchForBillsBaySupplierName(),
                  ),

                  Custom_dropDownButton(
                    value:
                        controller
                            .selectedSupplierCity, // Use the controller's selected value
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
