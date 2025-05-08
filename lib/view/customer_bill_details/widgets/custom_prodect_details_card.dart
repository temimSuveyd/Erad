
import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/data/data_score/static/customer_bill_add/customer_label_data.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_prodect_text_container.dart';

class Custom_product_details_card extends StatelessWidget {
  const Custom_product_details_card({super.key});

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
            spacing: 100,
            children: [
              ...List.generate(
                4,
                (index) => Custom_product_text_container(
                  title: customerLabelData[index].title,
                  isproductName: index == 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
