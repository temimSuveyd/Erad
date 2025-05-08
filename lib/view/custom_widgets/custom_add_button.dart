import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_button extends StatelessWidget {
  const Custom_button({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      minWidth: 120,
      height: 45,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      color: AppColors.primary,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.wihet,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(width: 10),

          Icon(icon, color: AppColors.wihet),
        ],
      ),
    );
  }
}
