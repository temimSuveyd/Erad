import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class CustomerNameLabel extends StatelessWidget {
  const CustomerNameLabel({
    super.key,
    required this.title,
    required this.width,
  });
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return Container(
      width: isDesktop ? width : null,
      alignment: Alignment.center,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: isDesktop ? 20 : 8,
        vertical: 5,
      ),
      height: 40,
      color: AppColors.primary,
      child: Text(
        title,
        style: TextStyle(color: AppColors.wihet, fontSize: isDesktop ? 20 : 16),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
