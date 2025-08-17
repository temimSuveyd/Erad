import 'package:Erad/data/model/suppliers/suppliers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_title_text_container.dart';
import 'package:Erad/view/custom_widgets/custom_add_button.dart';
import 'package:Erad/view/customer_bills_add/widgets/custom_price_container.dart';

class Custom_suppliers_Card extends StatelessWidget {
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
              Custom_price_container(title: suppliersModel.supplier_city!, width: 190),
              Custom_button( color: AppColors.primary,
                icon: Icons.document_scanner,
                onPressed: () {},
                title: "فواتير",
              ),
              Custom_button( color: AppColors.primary,icon: Icons.edit, onPressed: () {}, title: "يحرر"),
            ],
          ),
        ),
      ],
    );
  }
}
