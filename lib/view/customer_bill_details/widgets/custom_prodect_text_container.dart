
import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_product_text_container extends StatelessWidget {
  const Custom_product_text_container({
    super.key,
    required this.isproductName,
    required this.title,
  });

  final bool isproductName;

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: isproductName == true ? 300 : 200,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
