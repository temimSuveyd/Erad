import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_price_container extends StatelessWidget {
  const Custom_price_container({
    super.key,
    required this.title,
    required this.width,
  });
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Text(
        title,
         overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
