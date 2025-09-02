import 'package:flutter/cupertino.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_date_text_container extends StatelessWidget {
  const Custom_date_text_container({super.key, required this.title, required this.width});
final String title;
final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 40,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}