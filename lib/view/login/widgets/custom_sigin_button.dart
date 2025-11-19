import 'package:flutter/material.dart';
import 'package:erad/core/constans/colors.dart';

// ignore: camel_case_types
class Custom_sigin_button extends StatelessWidget {
  const Custom_sigin_button({super.key, required this.onPressed});

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },

      minWidth: double.maxFinite,
      color: AppColors.grey.withOpacity(0.5),
      height: 45,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.wihet),
      ),
      splashColor: Colors.transparent,
      elevation: 0,
      child: Text(
        "تسجيل الدخول",
        style: TextStyle(color: AppColors.wihet, fontSize: 18),
      ),
    );
  }
}
