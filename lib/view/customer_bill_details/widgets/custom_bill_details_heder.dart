import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/customer_bill_details/widgets/custom_biil_details_text_container.dart';

class Custom_bill_details_heder extends StatelessWidget {
  const Custom_bill_details_heder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            height: 50,

            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.grey,
            ),

            child: Row(
              spacing: 10,
              children: [
                ...List.generate(
                  4,
                  (index) => Custom_biil_details_text_container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
