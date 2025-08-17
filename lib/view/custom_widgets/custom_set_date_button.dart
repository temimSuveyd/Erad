import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Erad/core/constans/colors.dart';

class Custom_set_date_button extends StatelessWidget {
  const Custom_set_date_button({
    super.key,
    required this.hintText,
    required this.onPressed,
  });

  final String hintText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: MaterialButton(
        height: 42,
        onPressed: () {
          onPressed();
        },

        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey, width: 2),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: TextStyle(color: AppColors.grey, fontSize: 18),
            ),
            Icon(Icons.date_range, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
