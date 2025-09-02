import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

class Custom_add_button extends StatelessWidget {
  const Custom_add_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      minWidth: 100,
      height: 40,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      color: AppColors.primary,
      child: Row(
        children: [
          Icon(Icons.add, color: AppColors.wihet),
          SizedBox(width: 10),
          Text(
            "إضافة",
            style: TextStyle(
              color: AppColors.wihet,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
