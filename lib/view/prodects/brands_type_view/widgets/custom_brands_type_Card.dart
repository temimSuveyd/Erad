import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/brands/brands_type_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/model/prodect/prodect_model.dart';
import 'package:Erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';

import '../../../supplier/suppliers_bills_add/widgets/custom_price_container.dart';

// ignore: camel_case_types
class Custom_brands_type_Card extends GetView<BrandsTypeControllerImp> {
  const Custom_brands_type_Card({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(5),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            spacing: 10,
            children: [
              Custom_price_container(title: productModel.title!, width: 220),
              Custom_price_container(title: productModel.size!, width: 210),
              Custom_price_container(
                title: productModel.buiyng_price!,
                width: 160,
              ),
              Custom_price_container(
                title: productModel.sales_pice!,
                width: 150,
              ),
              Custom_price_container(title: productModel.profits!, width: 150),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.delete_forever,
                onPressed:
                    () => controller.show_delete_dialog(productModel.title!),
                title: "حذف",
              ),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.edit,
                onPressed:
                    () => controller.show_edit_dialog(
                      productModel.sales_pice!,
                      productModel.buiyng_price!,
                      productModel.size!,
                      productModel.title!,
                    ),
                title: "يحرر",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
