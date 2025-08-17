import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';

class CustomerNameLabel extends StatelessWidget {
  const CustomerNameLabel({super.key, required this.title, required this.width});
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
      height: 40,
      color: AppColors.primary,
      child: Text(
        title,
        style: TextStyle(color: AppColors.wihet, fontSize: 20),
      ),
    );
  }
}
