import 'package:flutter/cupertino.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_date_text_container.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_price_text_container.dart';

class Custom_debt_payments_card extends StatelessWidget {
  const Custom_debt_payments_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Custom_date_text_container(), Custom_price_text_container()],
      ),
    );
  }
}


