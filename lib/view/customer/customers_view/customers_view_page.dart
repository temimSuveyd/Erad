import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erad/controller/customers/customers_view/customers_controller.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/data_score/static/city_data.dart';
import 'package:erad/view/custom_widgets/custom_dropDownButton.dart';
import 'package:erad/view/custom_widgets/custom_appBar.dart';
import 'package:erad/view/custom_widgets/custom_text_field.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_brands_heder.dart';
import 'package:erad/view/customer/customers_view/widgets/custom_brands_listView.dart';
import 'package:erad/view/supplier/suppliers_view/widgets/custom_suppliers_listView.dart';

class CustomersViewPage extends GetView<CustomersControllerImp> {
  const CustomersViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomersControllerImp());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: Custom_appBar(title: "زبائني"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 10,
                children: [
                  Custom_textfield(
                    hintText: 'ابحث عن العملاء',
                    suffixIcon: Icons.search,
                    validator: (String? validator) {
                      return null;
                    },
                    controller: controller.search_controller,
                    onChanged: (p0) {
                      controller.searchForCustomersBayName();
                    },
                  ),
                  GetBuilder<CustomersControllerImp>(
                    builder:
                        (controller) => Custom_dropDownButton(
                          onChanged: (String value) {
                            controller.searchForCustomersBayCity(value);
                          },
                          hint: controller.customer_city,
                          items: city_data,
                          value: '',
                        ),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30)),

            SliverToBoxAdapter(
              child: Row(children: [Custom_customers_heder()]),
            ),

            Custom_customers_listView(),
          ],
        ),
      ),
    );
  }
}
