

import 'package:flutter/cupertino.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_debt_payment_type_heder extends StatelessWidget {
  const Custom_debt_payment_type_heder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          width: 500,
          height: 40,
          color: AppColors.primary,

          child: Row(
            spacing: 10,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$title :",
                style: TextStyle(
                  color: AppColors.wihet,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                "12030",
                style: TextStyle(
                  color: AppColors.wihet,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
