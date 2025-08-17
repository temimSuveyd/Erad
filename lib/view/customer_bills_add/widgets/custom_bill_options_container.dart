import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/customers/customer_add_bill_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom__dropDownButton.dart';
import 'package:Erad/view/custom_widgets/custom_date_picker_button.dart';

class CustomerBillOptionsContainer extends StatelessWidget {
  const CustomerBillOptionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            // CustomerBillOptionsContainer
            Container(
              height: 50,
              // width: 500,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.grey,
              ),

              child: GetBuilder<CustomerBiilAddControllerImp>(
                builder:
                    (controller) => Row(
                      spacing: 20,
                      children: [
                        Custom_dropDownButton(
                          items: controller.customers_list_dropdownItrm,
                          onChanged: (value) {
                            controller.setCustomer(value);
                          },
                          hint: controller.customer_name ?? "اسم العميل",
                          value: "",
                        ),

                        Custom_date_picker_button(),

                        GetBuilder<CustomerBiilAddControllerImp>(
                          builder:
                              (controller) => Custom_dropDownButton(
                                items: [
                                  DropdownMenuItem(
                                    value: "Religion",
                                    child: Text("دَين"),
                                  ),
                                  DropdownMenuItem(
                                    value: "monetary",
                                    child: Text("نقدي"),
                                  ),
                                ],
                                onChanged:
                                    (value) => controller.setPaymentType(value),

                                hint:
                                    controller.bill_payment_type == "Religion"
                                        ? "دَين"
                                        : "نقدي",
                                value: "",
                              ),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
