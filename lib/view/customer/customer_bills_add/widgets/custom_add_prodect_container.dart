import 'package:erad/view/supplier/bills/suppliers_bills_add/widgets/custom_price_container.dart';
import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';
import 'package:erad/data/model/customer_bill_add/prodects_model.dart';
import 'package:erad/view/customer/Customer_bills_view/widgets/custom_title_container.dart';
import 'package:erad/view/custom_widgets/custom_add_button.dart';

// ignore: camel_case_types
class Custom_add_product_container extends StatelessWidget {
  const Custom_add_product_container({
    super.key,
    required this.billProductsModel,
    required this.onPressed, 
  });

  final BillProductsModel billProductsModel;
  final Function() onPressed ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              spacing: 20,
              children: [
                Custom_title_container(
                  title: billProductsModel.product_name!,
                  color: AppColors.grey,
                ),

                Custom_price_container(
                  title: billProductsModel.product_number!.toString(),
                  width: 180,
                ),
                Custom_price_container(
                  title: billProductsModel.product_price!.toString(),
                  width: 180,
                ),
                Custom_price_container(
                  title: billProductsModel.prodect_totla_price!.toString(),
                  width: 180,
                ),

                Custom_button( color: AppColors.primary,icon: Icons.delete, title: "حذف", onPressed: () {
                  onPressed();
                },)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
