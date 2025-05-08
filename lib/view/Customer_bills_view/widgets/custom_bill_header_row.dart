import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';
import 'package:suveyd_ticaret/view/Customer_bills_view/widgets/custom_title_container.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_details_button.dart';
import 'package:suveyd_ticaret/view/custom_widgets/custom_title_text_container.dart';
import 'package:suveyd_ticaret/view/customer_bills_add/widgets/custom_price_container.dart';


class Custom_bill_view_card extends StatelessWidget {
  const Custom_bill_view_card({
    super.key,

  });

  

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
            spacing: 30,
            children: [
   Custom_title_text_container(title: ""),
   Custom_price_container(title: "", width: 250),
   Custom_price_container(title: "", width: 200),
   Custom_price_container(title: "", width: 200),
   Custom_price_container(title: "", width: 200),


              // Spacer(),
              Custom_details_button(),
            ],
          ),
        ),
      ],
    );
  }
}
