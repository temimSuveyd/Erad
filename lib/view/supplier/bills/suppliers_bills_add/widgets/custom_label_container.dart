import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Csutom_label_container extends StatelessWidget {
  const Csutom_label_container({
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
      height: 40,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: AppColors.primary,
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.wihet,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
