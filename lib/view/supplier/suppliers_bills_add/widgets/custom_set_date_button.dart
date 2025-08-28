import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';

class Csutom_set_date_reng_button extends StatelessWidget {
  const Csutom_set_date_reng_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 10),
      minWidth: 250,
      height: 43,
    
      color: AppColors.wihet,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.date_range, color: AppColors.grey),
          Text(
            "اختر نطاق الوقت",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
