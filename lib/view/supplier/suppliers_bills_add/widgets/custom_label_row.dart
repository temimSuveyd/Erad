import 'package:Erad/view/supplier/suppliers_bills_add/widgets/custom_label_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:Erad/controller/customers/customer_add_bill_controller.dart';
import 'package:Erad/data/data_score/static/customer_bill_add/customer_label_data.dart';

class Custom_label_row extends GetView<CustomerBiilAddControllerImp> {
  Custom_label_row({super.key});

  final List<double> widthList = [310, 200, 200, 200];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: Row(
          spacing: 2,
          children: [
            ...List.generate(
              customerLabelData.length,
              (index) => Csutom_label_container(
                title: customerLabelData[index].title,
                width: widthList[index],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
