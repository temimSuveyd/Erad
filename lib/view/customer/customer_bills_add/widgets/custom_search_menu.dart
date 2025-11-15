import 'package:erad/controller/customers/bills/customer_add_bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_serach_menu extends StatelessWidget {
  const Custom_serach_menu({super.key});

  @override
  Widget build(BuildContext context) {
    // Not using Positioned here to allow proper gesture handling
    return GetBuilder<CustomerBiilAddControllerImp>(
      builder: (controller) {
        if (!controller.show_search_popupMenu) return SizedBox();
        return Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            margin: const EdgeInsets.only(right: 5, top: 53),
            padding: EdgeInsets.all(5),
            width: 290,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey,
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
              color: AppColors.wihet,
              borderRadius: BorderRadius.circular(5),
            ),
            child: controller.all_product_list.isEmpty
                ? Text(
                    "المنتج الذي تبحث عنه غير متوفر",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        controller.all_product_list.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(2),
                            onTap: () =>
                                controller.setProductFromSearch(
                                  controller.all_product_list[index]["product_name"],
                                ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grey,
                                  width: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                controller.all_product_list[index]["product_name"],
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
