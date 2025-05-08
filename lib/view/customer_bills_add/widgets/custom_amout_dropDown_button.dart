import 'package:flutter/material.dart';
import 'package:suveyd_ticaret/core/constans/colors.dart';

class Csutom_count_textField extends StatelessWidget {
  const Csutom_count_textField({
    super.key,
    required this.hintText,
    required this.controller,
    // required this.validator,
    required this.suffixIcon,
  });

  final String hintText;
  final TextEditingController controller;
  // final String Function(String) validator;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: TextFormField(
        // validator: (value) => validator(value!),
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.grey, fontSize: 20),
          filled: true,
          fillColor: AppColors.wihet,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
