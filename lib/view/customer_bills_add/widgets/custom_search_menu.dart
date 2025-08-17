import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Erad/controller/customers/customer_add_bill_controller.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_serach_menu extends StatelessWidget {
  const Custom_serach_menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 53,
      width: 290,
      child: GetBuilder<CustomerBiilAddControllerImp>(
        builder:
            (controller) =>
                controller.show_search_popupMenu
                    ? Container(
                      padding: EdgeInsets.all(5),
                      width: 290,
                      // height: 200,
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
                      child:
                          controller.all_product_list.isEmpty
                              ? Text(
                                "المنتج الذي تبحث عنه غير متوفر",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                ),
                              )
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ...List.generate(
                                    controller.all_product_list.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: MaterialButton(
                                        
                                        minWidth: double.maxFinite,
                                        padding: EdgeInsets.all(5),
                                        shape: Border.all(
                                          color: AppColors.grey,
                                          width: 0.4,
                                        ),
    
                                        onPressed:
                                            () => controller.setProductFromSearch(
                                              controller
                                                  .all_product_list[index]["product_name"],
                                            ),
                                        child: Text(
                                          controller
                                              .all_product_list[index]["product_name"],
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    )
                    : SizedBox(),
      ),
    );
  }
}
