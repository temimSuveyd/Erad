import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_button extends StatelessWidget {
  const Custom_button({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Function() onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      padding: EdgeInsets.symmetric(horizontal: 20),
      minWidth: 120,
      height: 45,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.wihet,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(width: 5),

          Icon(icon, color: AppColors.wihet),
        ],
      ),
    );
  }
}
