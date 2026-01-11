import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/custom_add_produc_Textfield.dart';
import 'package:erad/view/customer/customer_bills_add/widgets/custom_search_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';


class Custom_add_product_card extends StatelessWidget {
  const Custom_add_product_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                height: 50,
                width: 645,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.grey,
                ),
              ),
            ),

            Positioned(
              right: 5,
              top: 7,
              child: GetBuilder<CustomerBiilAddControllerImp>(
                builder:
                    (controller) => Custom_add_produc_Textfield(
                      focusNode: controller.focusNode1,
                      controller: controller.serach_for_product_controller,
                      key: controller.textFieldKey,
                      hintText: "اسم المنتج",
                      width: 290,
                      onChanged: (p0) => controller.searchForProduct(),
                      onSubmitted: (p0) {
                        controller.hiden_search_Menu();
                        controller.setProductFromSearch(
                          controller.all_product_list[0]["product_name"],
                        );
                      },
                    ),
              ),
            ),
            Positioned(
              right: 330,
              top: 7,
              child: GetBuilder<CustomerBiilAddControllerImp>(
                builder:
                    (controller) => Custom_add_produc_Textfield(
                      focusNode: controller.focusNode2,
                      onSubmitted:
                          (p0) =>
                              controller.addProduct(controller.product_name!),
                      controller: controller.number_of_products_controller,
                      width: 150,
                      hintText: "كمية",
                      onChanged: (p0) {},
                    ),
              ),
            ),

            Custom_serach_menu(),

            Positioned(
              right: 520,
              top: 6,

              child: GetBuilder<CustomerBiilAddControllerImp>(
                builder:
                    (controller) => CustomButton( color: AppColors.primary,
                      icon: Icons.add,
                      title: "أضف",
                      onPressed:
                          () => controller.addProduct(controller.product_name!),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
