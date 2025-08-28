
import 'package:Erad/controller/suppliers/suppliers_bill_add_controller.dart';
import 'package:Erad/controller/suppliers/suppliers_bill_view_controller.dart';
import 'package:Erad/view/custom_widgets/custom_bill_status_dialog.dart';
import 'package:Erad/view/custom_widgets/handling_bill_status.dart';
import 'package:Erad/view/supplier/suppliers_bills_add/widgets/custom_price_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Erad/controller/customers/customer_bill_view_controller.dart';
import 'package:Erad/core/constans/colors.dart';

import 'package:Erad/view/custom_widgets/custom_add_button.dart';

import '../../../../data/model/supplier_bill_view/bill_model.dart';


class Custom_bill_view_card extends GetView<SuppliersBillViewControllerImp> {
  const Custom_bill_view_card({super.key, required this.billModel});
  final BillModel billModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsetsDirectional.all(5),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            spacing: 10,
            children: [
              Custom_price_container(
                title: billModel.supplier_name!,
                width: 200,
              ),
              Custom_price_container(
                title: billModel.supplier_city!,
                width: 200,
              ),

              Custom_price_container(
                title:
                    "${billModel.bill_date!.day}/${billModel.bill_date!.month}/${billModel.bill_date!.year}",
                width: 160,
              ),
              Custom_price_container(
                title: billModel.total_price!.toString(),
                width: 160,
              ),
              Custom_price_container(
                title: billModel.payment_type == "Religion" ? "دِين" : "نقدي",
                width: 160,
              ),

              // Spacer(),
              // Custom_details_button(),
              Custom_button(
                color: AppColors.primary,
                icon: Icons.open_in_new,
                title: "تفاصيل",
                onPressed: () {
                  controller.goToDetailsPage(billModel.bill_id!);
                },
              ),
              Bill_status_button(
                billStatus: billModel.bill_status!,
                onPressed: () {
                  custom_bill_status_dialog(billModel.bill_status!, (value) {
                    controller.updateBillStaus(value, billModel.bill_id!);
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
