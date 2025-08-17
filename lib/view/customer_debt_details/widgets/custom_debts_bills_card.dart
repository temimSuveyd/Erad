import 'package:flutter/cupertino.dart';
import 'package:Erad/core/constans/colors.dart';
import 'package:Erad/view/custom_widgets/custom_date_text_container.dart';
import 'package:Erad/view/custom_widgets/custom_details_button.dart';
import 'package:Erad/view/custom_widgets/custom_price_text_container.dart';

class Custom_debts_bills_card extends StatelessWidget {
  const Custom_debts_bills_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(bottom: 5),
      width: 500,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Custom_date_text_container(),
          Custom_price_text_container(),
          Custom_details_button(),
        ],
      ),
    );
  }
}

