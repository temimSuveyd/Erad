import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_title_container extends StatelessWidget {
  const Custom_title_container({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.wihet,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
    );
  }
}