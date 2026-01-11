import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSetDateButton extends StatelessWidget {
  const CustomSetDateButton({
    super.key,
    this.onPressed,
    required this.hintText,
  });

  final void Function()? onPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return MaterialButton(
      onPressed: () => onPressed!(),
      height: 46,
      minWidth: isDesktop ? Get.width * 0.15 : double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: BorderSide(color: AppColors.grey, width: 0.6),
      ),
      child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.date_range, color: AppColors.primary, size: 24),
          Text(
            hintText,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: isDesktop ? 18 : 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
