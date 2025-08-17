import 'package:flutter/material.dart';
import 'package:Erad/core/constans/colors.dart';

// ignore: camel_case_types
class Custom_login_textfield extends StatelessWidget {
  const Custom_login_textfield({super.key, required this.hintText, required this.controller, required this.validator});
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(

        style: TextStyle(color: AppColors.wihet),
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: AppColors.wihet,
            fontWeight: FontWeight.w400,
          ),

          filled: true,
          fillColor: const Color.fromARGB(92, 46, 46, 46),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
