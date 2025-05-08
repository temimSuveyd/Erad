import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_title_container.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_details_button.dart';

class BillHeaderRow extends StatelessWidget {
  const BillHeaderRow({
    super.key,
    required this.titleList,
    required this.width,
  });

  final List<String> titleList;
  final List<double> width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsetsDirectional.all(5),
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        spacing: 30,
        children: [
          ...List.generate(
            5,
            (index) => Custom_title_container(
              title: titleList[index],
          
              color: AppColors.black,
            ),
          ),

          // Spacer(),
          Custom_details_button(),
        ],
      ),
    );
  }
}
