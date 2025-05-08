import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class CustomerNameLabel extends StatelessWidget {
  const CustomerNameLabel({super.key, required this.title, required this.widgets});
  final String title;
  final double widgets;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widgets,
      alignment: Alignment.center,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 80, vertical: 5),
      height: 40,
      color: AppColors.primary,
      child: Text(
        title,
        style: TextStyle(color: AppColors.wihet, fontSize: 20),
      ),
    );
  }
}
