import 'package:erad/core/constans/colors.dart';
import 'package:flutter/material.dart';

class Custom_bill_status_button extends StatelessWidget {
  const Custom_bill_status_button({
    super.key,
    required this.color,
    required this.onPressed,
    required this.title,
  });
  final Color color;
  final void Function() onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.verified_outlined, color: Colors.white),
      label: Text(title, style: TextStyle(color: AppColors.wihet)),
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () {
        onPressed();
      },
    );
  }
}