
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/data/data_score/static/customer_bill_add/customer_label_data.dart';

class Csutom_lable_details extends StatelessWidget {
  Csutom_lable_details({super.key});

  final List<double> widget_width = [350, 300, 300, 300];
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: Get.width,
        child: Row(
          spacing: 3,
          children: [
            ...List.generate(
              customerLabelData.length,
              (index) => Container(
                height: 40,
                width: widget_width[index],
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.primary),
                child: Text(
                  customerLabelData[index].title,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



