import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_biil_details_text_container extends StatelessWidget {
  const Custom_biil_details_text_container({
    super.key,
    required this.title_1,
    required this.title_2,
    required this.color,
  });
  final String title_1;
  final String title_2;
  final Color color;

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

      child: Row(
        children: [
          Text(
            "$title_2 : ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          Text(
            title_1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
