import 'package:flutter/cupertino.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_date_text_container extends StatelessWidget {
  const Custom_date_text_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "2025/01/13",
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}