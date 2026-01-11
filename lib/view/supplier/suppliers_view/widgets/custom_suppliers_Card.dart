import 'package:erad/controller/suppliers/suppliers_view/suppliers_view_controller.dart';
import 'package:erad/data/model/suppliers/suppliers_model.dart';
import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/custom_price_container.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';
import 'package:get/get.dart';

class Custom_suppliers_Card extends GetView<SuppliersControllerImp> {
  const Custom_suppliers_Card({super.key, required this.suppliersModel});
  final SuppliersModel suppliersModel;
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
            spacing: 20,
            children: [
              Custom_title_text_container(title: suppliersModel.supplier_name!),
              Custom_price_container(
                title: suppliersModel.supplier_city!,
                width: 190,
              ),
              CustomButton(
                color: AppColors.primary,
                icon: Icons.delete,
                onPressed:
                    () =>
                        controller.show_delete_dialog(suppliersModel.supplier_id!),
                title: 'حذف',
              ),
              CustomButton(
                color: AppColors.primary,
                icon: Icons.edit,
                onPressed: () => controller.show_edit_dialog(suppliersModel),
                title: "تعديل",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
