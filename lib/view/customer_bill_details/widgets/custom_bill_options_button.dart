
import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Custom_bill_options_button extends StatelessWidget {
  const Custom_bill_options_button({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      // minWidth: 150,
      color: AppColors.primary,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),

      child: Row(
        spacing: 10,
        children: [
          Icon(icon, color: AppColors.wihet),
          Text(title, style: TextStyle(fontSize: 20, color: AppColors.wihet)),
        ],
      ),
    );
  }
}

