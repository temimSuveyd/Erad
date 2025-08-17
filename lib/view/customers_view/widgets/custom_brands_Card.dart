import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customers_controller.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/data/model/customers/customers_model.dart';
import 'package:Erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_price_container.dart';

class Custom_customers_Card extends GetView<CustomersControllerImp> {
  const Custom_customers_Card({super.key, required this.customersModel});
  final CustomersModel customersModel;
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
              Custom_title_text_container(title: customersModel.customer_name!),
              Custom_price_container(
                title: customersModel.customer_city!,
                width: 190,
              ),

              Custom_button( color: AppColors.primary,icon: Icons.edit, onPressed:() => controller.show_edit_dialog(customersModel.customer_id!, customersModel.customer_city!, customersModel.customer_name!), title: "حرر"),
              Custom_button( color: AppColors.primary,
                icon: Icons.delete_forever,
                onPressed:
                    () => controller.show_delete_dialog(
                      customersModel.customer_id!,
                    ),
                title: "حذف",
              ),
              Custom_button( color: AppColors.primary,
                icon: Icons.document_scanner,
                onPressed: () {},
                title: "فواتير",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
