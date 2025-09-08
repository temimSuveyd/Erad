import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_heder.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_listView.dart';
import 'package:get/get.dart';

class SuppliersViewPage extends GetView<SuppliersControllerImp> {
  const SuppliersViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuppliersControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "الموردين"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 10,
                children: [
                  Custom_textfield(
                    hintText: "اسم المورد",
                    suffixIcon: Icons.search_sharp,
                    validator: (String? validator) {
                      return null;
                    },
                    controller: controller.search_controller,
                    onChanged: (p0) => controller.searchForSuppliersBayName(),
                  ),
                  GetBuilder<SuppliersControllerImp>(
                    builder:
                        (controller) => Custom_dropDownButton(
                          onChanged:
                              (value) =>
                                  controller.searchForSuppliersBayCity(value),
                          hint: controller.suppliers_city ,
                          items: city_data,
                          value: '',
                        ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(
              child: Row(children: [Custom_suppliers_heder()]),
            ),

            Custom_suppliers_listView(),
          ],
        ),
      ),
    );
  }
}
