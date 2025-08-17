
import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_total_price_container extends StatelessWidget {
  const Custom_total_price_container({
    super.key, required this.title,
  });


final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
    
      margin: EdgeInsets.symmetric(vertical: 30),
      width: 200,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "إجمالي السعر",
              style: TextStyle(
                color: AppColors.wihet,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
    
          Text(
           title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.wihet,
            ),
          ),
        ],
      ),
    );
  }
}
