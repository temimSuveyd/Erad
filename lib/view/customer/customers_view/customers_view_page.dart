import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customers_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/data_score/static/city_data.dart';
import 'package:Erad/view/custom_widgets/custom__dropDownButton.dart';
import 'package:Erad/view/custom_widgets/custom_appBar.dart';
import 'package:Erad/view/custom_widgets/custom_search_text_field.dart';
import 'package:Erad/view/customer/customers_view/widgets/custom_brands_heder.dart';
import 'package:Erad/view/customer/customers_view/widgets/custom_brands_listView.dart';
import 'package:Erad/view/supplier/suppliers_view/widgets/custom_suppliers_listView.dart';

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
                    validator: (String? validator) {},
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
