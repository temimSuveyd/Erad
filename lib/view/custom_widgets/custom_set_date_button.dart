import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';

class Custom_set_date_button extends StatelessWidget {
  const Custom_set_date_button({
    super.key,
    this.onPressed,
    required this.hintText,
  });

  final void Function()? onPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed!(),
      height: 44,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey, width: 2),
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
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
