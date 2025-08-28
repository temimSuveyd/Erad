import 'package:Erad/controller/suppliers/suppliers_bill_details_controller.dart';
import 'package:Erad/data/model/customer_bill_details/bill_details_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/customer/customer_bill_details/widgets/custom_prodect_text_container.dart';

class Custom_product_details_card
    extends GetView<SuppliersBillDetailsControllerImp> {
  const Custom_product_details_card({
    super.key,
    required this.billProductsModel,
  });

  final BillDetailsProductsModel billProductsModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 10),
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            spacing: 20,
            children: [
              Custom_product_text_container(
                title: billProductsModel.product_name!,
                isproductName: true,
              ),
              Custom_product_text_container(
                title: billProductsModel.product_number.toString(),
                isproductName: false,
              ),
              Custom_product_text_container(
                title: billProductsModel.product_price.toString(),
                isproductName: false,
              ),
              Custom_product_text_container(
                title: billProductsModel.prodect_totla_price.toString(),
                isproductName: false,
              ),

              Custom_button(
                color: AppColors.primary,
                icon: Icons.edit,
                title: "تعديل",
                onPressed:
                    () => controller.editProductData(billProductsModel.id!),
              ),

              Custom_button(
                color: AppColors.primary,
                icon: Icons.delete,
                title: "حذف",
                onPressed:
                    () => controller.show_delete_product_dialog(
                      billProductsModel.id!,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
