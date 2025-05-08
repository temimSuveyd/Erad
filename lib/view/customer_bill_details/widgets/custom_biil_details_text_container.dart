import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_biil_details_text_container extends StatelessWidget {
  const Custom_biil_details_text_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.wihet,
      ),

      child: Text(
        "Muhamed hikmet sevim",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
